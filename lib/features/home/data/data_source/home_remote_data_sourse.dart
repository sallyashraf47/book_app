import 'package:book_app/constants.dart';
import 'package:book_app/core/api_services.dart';
import 'package:book_app/features/home/data/models/book_model/book_model.dart';
import 'package:book_app/features/home/domain/entity/book_entity.dart';
import '../../../../core/function/save_box_hive.dart';

abstract class HomeRemoteDataSource{
 Future<List<BookEntity>> fetchFeaturesBooks({int pageNumber=0});
 Future<List<BookEntity>> fetchNewsBooks();

}
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{
 final ApiServices apiServices;

  HomeRemoteDataSourceImpl(this.apiServices);
  @override
  Future<List<BookEntity>> fetchFeaturesBooks({int pageNumber=0}) async {
var data= await apiServices.get(endPoint:
'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}');
List<BookEntity> books=getBookList(data);
 saveBook(books: books,boxName: kFeaturedBox);
 return books;
  }

  @override
  Future<List<BookEntity>> fetchNewsBooks() async{
    var data=  await apiServices.get(endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest&q=programming');

    List <BookEntity> books=getBookList(data);
    //save  book inside box hive
    saveBook(boxName: kNewestBox, books: books);
return books;
    }
  }
List<BookEntity> getBookList(Map<String,dynamic> data){
    List<BookEntity>books=[];
    for(var bookMap in data['items']){
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
}
