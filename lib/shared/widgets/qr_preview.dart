import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QRPreview extends StatelessWidget {
  final String data;
  final VoidCallback? onSaveToLocalHistory;

  const QRPreview({super.key, required this.data, this.onSaveToLocalHistory});

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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSuccess ? 'QR code saved to gallery!' : 'Failed to save QR code',
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _shareQR(Uint8List pngBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/qr_vault_share.png').create();
    await file.writeAsBytes(pngBytes);
    final params = ShareParams(text: "QR Vault", files: [XFile(file.path)]);
    await SharePlus.instance.share(params);
  }

  Future<Uint8List> _generateQrImageBytes() async {
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.Q,
    );
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode!,
      gapless: false,
      color: Colors.black,
      emptyColor: Colors.white,
    );
    final picData = await painter.toImageData(
      1024,
      format: ImageByteFormat.png,
    );
    return picData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surface;
    return Center(
      child: SizedBox(
        width: 500,
        height: 500,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(data: data, size: 200, backgroundColor: Colors.white),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                  onPressed: () async {
                    final pngBytes = await _generateQrImageBytes();
                    await _shareQR(pngBytes);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text("Save to Gallery"),
                  onPressed: () async {
                    final pngBytes = await _generateQrImageBytes();
                    await _saveImageToGallery(context, pngBytes);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save Locally"),
                  onPressed: () {
                    onSaveToLocalHistory?.call();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
