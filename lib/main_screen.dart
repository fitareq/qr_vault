import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_vault/feature/generate/presentation/generator_screen.dart';

import 'core/constants/app_strings.dart';
import 'feature/history/history_screen.dart';
import 'feature/home/home_screen.dart';
import 'feature/scanner/presentation/scanner_screen.dart';
import 'feature/settings/settings_screen.dart';

class QRVaultHomeScreen extends StatefulWidget {
  const QRVaultHomeScreen({super.key});

  @override
  State<QRVaultHomeScreen> createState() => _QRVaultHomeScreenState();
}

class _QRVaultHomeScreenState extends State<QRVaultHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    GeneratorScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          _currentIndex > 2
              ? _screens[_currentIndex - 1]
              : _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScannerScreen()),
          );
        },
        tooltip: AppStrings.scan,
        child: SvgPicture.asset('assets/icons/ic_scan.svg', width: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 2) return;
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_home_outlined.svg',
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_home_filled.svg',
                width: 24,
              ),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_generate_outlined.svg',
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_generate_filled.svg',
                width: 24,
              ),
              label: AppStrings.generate,
            ),
            const BottomNavigationBarItem(icon: Icon(null), label: ''),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_history_outlined.svg',
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_history_filled.svg',
                width: 24,
              ),
              label: AppStrings.history,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_settings_outlined.svg',
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_settings_filled.svg',
                width: 24,
              ),
              label: AppStrings.settings,
            ),
          ],
        ),
      ),
    );
  }
}
