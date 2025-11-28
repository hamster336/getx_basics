import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'notes.g.dart';

@HiveType(typeId: 0)
class Notes extends HiveObject{
  @HiveField(0) String title;
  @HiveField(1) String content;
  @HiveField(2) String time;

  Notes({
    required this.title,
    required this.content,
    required this.time,
  });
}