import 'package:hive/hive.dart';

part 'qr_history_model.g.dart';

@HiveType(typeId: 0)
class QRHistoryModel extends HiveObject {
  @HiveField(0)
  final String data;

  @HiveField(1)
  final DateTime timeStamp;

  @HiveField(2)
  final bool isGenerated;

  QRHistoryModel({
    required this.data,
    required this.timeStamp,
    required this.isGenerated,
  });
}
