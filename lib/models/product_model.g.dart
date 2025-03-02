// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      name: fields[0] as String? ?? '', // Provide default value if null
      namearabic: fields[1] as String? ?? '', // Provide default value if null
      description: fields[2] as String? ?? '', // Provide default value if null
      descriptionarabic:
          fields[3] as String? ?? '', // Provide default value if null
      id: fields[4] as String? ?? '', // Provide default value if null
      tid: fields[5] as String? ?? '', // Provide default value if null
      price: fields[6] as double? ?? 0.0, // Provide default value if null
      timer: fields[7] as String? ?? '', // Provide default value if null
      imagePath: fields[8] as String? ?? '', // Provide default value if null
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.namearabic)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.descriptionarabic)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.tid)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.timer)
      ..writeByte(8)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
