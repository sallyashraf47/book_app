import 'package:book_app/constants.dart';
import 'package:book_app/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource{
  List<BookEntity> fetchFeaturesBooks({int pageNumber =0});
  List<BookEntity>  fetchNewsBooks();
}
class HomeLocalDataSourceImpl extends HomeLocalDataSource{
  @override
  List<BookEntity> fetchFeaturesBooks({int pageNumber =0}) {
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    var box=Hive.box<BookEntity>(kFeaturedBox);

    int length = box.values.length;
if(startIndex>=length||endIndex>length){//1 10 //10
  return [];
}
    List<BookEntity> books=box.values.toList().sublist(startIndex,endIndex);
   return books;
  }

  @override
  List<BookEntity> fetchNewsBooks() {
    var box=Hive.box<BookEntity>(kFeaturedBox);


    List<BookEntity> books=box.values.toList();
    return books;

  }

}