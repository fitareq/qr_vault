import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:qr_vault/feature/history/models/qr_history_model.dart';

class HistoryProvider extends ChangeNotifier {
  static const _boxName = 'qr_history';

  late Box<QRHistoryModel> _box;

  List<QRHistoryModel> _allItems = [];

  List<QRHistoryModel> get scanned =>
      _allItems.where((e) => !e.isGenerated).toList();

  List<QRHistoryModel> get generated =>
      _allItems.where((e) => e.isGenerated).toList();

  Future<void> init() async {
    _box = await Hive.openBox<QRHistoryModel>(_boxName);
    _allItems = _box.values.toList();
    notifyListeners();
  }

  Future<void> addItem(QRHistoryModel item) async {
    await _box.add(item);
    _allItems = _box.values.toList();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await _box.clear();
    _allItems = _box.values.toList();
    notifyListeners();
  }
}
