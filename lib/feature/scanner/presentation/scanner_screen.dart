import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_vault/feature/scanner/presentation/widgets/animated_scan_line.dart';
import 'package:qr_vault/feature/scanner/presentation/widgets/barcode_overlay.dart';
import 'package:qr_vault/feature/scanner/presentation/widgets/custom_overlay.dart';
import 'package:vibration/vibration.dart';

import '../provider/scanner_provider.dart';
import '../utils/scanner_utils.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;
  ScanMode _scanMode = ScanMode.qrCode;
  bool _flashOn = false;

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null) return;

    _isProcessing = true;
    _controller.stop();

    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 200); // 200ms feedback
    }
    context.read<ScannerProvider>().setScannedData(code);
    _showResultDialog(code);
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("QR Code Result"),
            content: Text(result),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<ScannerProvider>().clearScannedData();
                  Navigator.of(context).pop();
                  _controller.start();
                  _isProcessing = false;
                },
                child: const Text("Scan Again"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _controller.start();
                  _isProcessing = false;
                },
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final cutOutWidth = MediaQuery.of(context).size.width * 0.8;
    final cutOutHeight = _scanMode == ScanMode.qrCode ? cutOutWidth : 100.0;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_scanMode == ScanMode.qrCode)
            ScannerOverlay(cutOutSize: cutOutWidth)
          else
            BarcodeScannerOverlay(
              cutOutWidth: cutOutWidth,
              cutOutHeight: cutOutHeight,
            ),

          // Animated scan line inside the box
          AnimatedScanLine(
            width: cutOutWidth,
            height: cutOutHeight,
            isVertical: _scanMode == ScanMode.qrCode,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),

          Positioned.fill(child: _buildOverlay(context)),

          // Blur + Buttons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _flashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _flashOn = !_flashOn;
                        });
                        _controller.toggleTorch();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Toggle
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(24),
                isSelected: [
                  _scanMode == ScanMode.qrCode,
                  _scanMode == ScanMode.barcode,
                ],
                onPressed:
                    (i) => setState(() {
                      _scanMode = ScanMode.values[i];
                    }),
                selectedColor: Colors.white,
                fillColor: Colors.black87,
                color: Colors.grey.shade300,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("QR Code"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Barcode"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
