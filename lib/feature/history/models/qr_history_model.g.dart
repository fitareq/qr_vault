// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QRHistoryModelAdapter extends TypeAdapter<QRHistoryModel> {
  @override
  final int typeId = 0;

  @override
  QRHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QRHistoryModel(
      data: fields[0] as String,
      timeStamp: fields[1] as DateTime,
      isGenerated: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QRHistoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.timeStamp)
      ..writeByte(2)
      ..write(obj.isGenerated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
