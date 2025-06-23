import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_vault/shared/widgets/overlay_snackbar.dart';
import 'package:qr_vault/shared/widgets/qr_export_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants/app_strings.dart';

class QRPreview extends StatelessWidget {
  final String data;
  final VoidCallback? onSaveToLocalHistory;
  bool isExporting = false;

  QRPreview({super.key, required this.data, this.onSaveToLocalHistory});

  final GlobalKey _qrKey = GlobalKey();

  Future<void> _saveImageToGallery(
    BuildContext context,
    Uint8List pngBytes,
  ) async {
    final result = await ImageGallerySaverPlus.saveImage(
      pngBytes,
      name: "qr_vault_${DateTime.now().microsecondsSinceEpoch}",
      quality: 100,
      isReturnImagePathOfIOS: true, // Optional
    );

    final isSuccess = result['isSuccess'] == true || result['filePath'] != null;
    if (isSuccess) {
      OverlaySnackBar.showSuccess(context, AppStrings.qrSavedToGallery);
    } else {
      OverlaySnackBar.showError(context, AppStrings.qrFailedToSave);
    }
  }

  Future<void> _shareQR(Uint8List pngBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/qr_vault_share.png').create();
    await file.writeAsBytes(pngBytes);
    final params = ShareParams(
      text: AppStrings.appName,
      files: [XFile(file.path)],
    );
    await SharePlus.instance.share(params);
  }

  Future<Uint8List> _generateQrImageBytes() async {
    await Future.delayed(Duration(milliseconds: 100));
    final boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.qrPreview,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // QR Code with shadow & background
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: QrImageView(
                    data: data,
                    size: 200,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Action Buttons
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildActionButton(
                    icon: Icons.share,
                    label: AppStrings.share,
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    onPressed: () async {
                      final pngBytes = await _generateQrImageBytes();
                      await _shareQR(pngBytes);
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.download,
                    label: AppStrings.saveToGallery,
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    onPressed: () async {
                      final pngBytes = await _generateQrImageBytes();
                      await _saveImageToGallery(context, pngBytes);
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.save,
                    label: AppStrings.saveToHistory,
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      onSaveToLocalHistory?.call();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Hidden widget for screenshot capture (off-screen but rendered)
          Positioned(
            left: -1000,
            top: -1000,
            child: RepaintBoundary(
              key: _qrKey,
              child: QRExportView(data: data),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPressed,
    );
  }
}
