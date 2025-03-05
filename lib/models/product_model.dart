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

  @HiveField(5)
  String tid; // Fix duplicate HiveField index (changed from 4 to 5)

  @HiveField(6)
  double price;

  @HiveField(7)
  String timer;

  @HiveField(8)
  String imagePath; // Fix duplicate HiveField index (changed from 7 to 8)

  Product({
    required this.name,
    required this.namearabic,
    required this.description,
    required this.descriptionarabic,
    required this.id,
    required this.tid,
    required this.price,
    required this.timer,
    required this.imagePath,
  });

  // Add this method to parse JSON into a Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      namearabic: json['namearabic'] ?? '',
      description: json['description'] ?? '',
      descriptionarabic: json['descriptionarabic'] ?? '',
      id: json['id'] ?? '',
      tid: json['tid'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      timer: json['timer'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }
}
