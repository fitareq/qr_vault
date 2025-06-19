import 'package:flutter/material.dart';

import '../utils/scanner_utils.dart';

class ScannerProvider extends ChangeNotifier {
  String? scannedData;
  ScanMode? _selectedMode;
  ScanMode? get selectedMode => _selectedMode;

  void setScannedData(String? data) {
    scannedData = data;
    notifyListeners();
  }

  void clearScannedData() {
    scannedData = null;
    notifyListeners();
  }

  void setScanMode(ScanMode mode) {
    _selectedMode = mode;
    notifyListeners();
  }

  void clearScanMode() {
    _selectedMode = null;
    notifyListeners();
  }
}
