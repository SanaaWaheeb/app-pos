import 'package:hive/hive.dart';

part 'help_model.g.dart';

@HiveType(typeId: 1)
class Help extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imagePath;

  Help({required this.title, required this.description, required this.imagePath});
}
