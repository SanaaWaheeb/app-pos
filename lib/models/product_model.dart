import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String namearabic;

  @HiveField(2)
  String description;

  @HiveField(3)
  String descriptionarabic;

  @HiveField(4)
  String id;

  @HiveField(4)
  String tid;

  @HiveField(5)
  double price;

  @HiveField(6)
  String timer;

  @HiveField(7)
  String imagePath;

  Product(
      {required this.name,
      required this.namearabic,
      required this.description,
      required this.descriptionarabic,
      required this.id,
      required this.tid,
      required this.price,
      required this.timer,
      required this.imagePath});
}
