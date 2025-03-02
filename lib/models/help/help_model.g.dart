// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HelpAdapter extends TypeAdapter<Help> {
  @override
  final int typeId = 1;

  @override
  Help read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Help(
      title: fields[0] as String,
      description: fields[1] as String,
      imagePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Help obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HelpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
