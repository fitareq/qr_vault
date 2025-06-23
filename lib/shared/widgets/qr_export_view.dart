import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_vault/core/constants/app_strings.dart';

class QRExportView extends StatelessWidget {
  final String data;

  const QRExportView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('MMM d, y – hh:mm a').format(now);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // QR Code
              QrImageView(
                data: data,
                size: 300,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(32),
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.black,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              // App branding (logo + name)
              Column(
                children: [
                  Image.asset(
                    'assets/images/qr_vault.png',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),

          // Watermark (bottom right)
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.2,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/qr_vault.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
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
