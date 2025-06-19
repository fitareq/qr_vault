import 'package:flutter/cupertino.dart';

import '../utils/generator_utils.dart';

class QRGeneratorProvider extends ChangeNotifier {
  QRType selectedType = QRType.text;
  String? generatedData;

  void selectType(QRType type) {
    selectedType = type;
    generatedData = null;
    notifyListeners();
  }

  void setGeneratedData(String data) {
    generatedData = data;
    notifyListeners();
  }

  void clear() {
    generatedData = null;
    notifyListeners();
  }
}
