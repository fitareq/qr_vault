import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_vault/core/theme/app_theme.dart';
import 'package:qr_vault/feature/generate/provider/generator_provider.dart';
import 'package:qr_vault/feature/scanner/provider/scanner_provider.dart';
import 'package:qr_vault/main_screen.dart';

class QRVaultApp extends StatefulWidget {
  const QRVaultApp({super.key});

  @override
  State<QRVaultApp> createState() => _QRVaultAppState();
}

class _QRVaultAppState extends State<QRVaultApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScannerProvider()),
        ChangeNotifierProvider(create: (_) => QRGeneratorProvider()),
      ],
      child: MaterialApp(
        title: "QR Vault",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        // or ThemeMode.light/ThemeMode.dark based on your preference
        home: const QRVaultHomeScreen(),
      ),
    );
  }
}
