import 'package:book_app/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

void saveBook({required String boxName, required List<BookEntity>books}){
  var box=Hive.box<BookEntity>(boxName);
  box.addAll(books);
}