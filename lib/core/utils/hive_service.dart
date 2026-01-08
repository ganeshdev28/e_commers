import 'package:hive/hive.dart';

class HiveService<T> {
  final Box<T> box;
  HiveService(this.box);

  List<T> getAll() => box.values.toList();
  void put(dynamic key, T value) => box.put(key, value);
  void delete(dynamic key) => box.delete(key);
}
