import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_vault/app.dart';
import 'package:qr_vault/feature/history/models/qr_history_model.dart';
import 'package:qr_vault/feature/history/provider/history_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(QRHistoryModelAdapter());

  final historyProvider = HistoryProvider();
  await historyProvider.init();
  runApp(const QRVaultApp());
}
