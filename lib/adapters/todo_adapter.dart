import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject  {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  Todo({required this.title,  required this.description});
}
