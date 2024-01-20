import 'package:book_app/core/errors/failure.dart';
import 'package:book_app/features/home/data/data_source/home_local_data_source.dart';
import 'package:book_app/features/home/data/data_source/home_remote_data_sourse.dart';
import 'package:book_app/features/home/domain/entity/book_entity.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo{
 final HomeRemoteDataSource homeRemoteDataSource;
 final HomeLocalDataSource  homeLocalDataSource;

  HomeRepoImpl({ required this.homeRemoteDataSource,required this.homeLocalDataSource});
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturesBook({int pageNumber=0})async {
List<BookEntity> books;
try {
  books=homeLocalDataSource.fetchFeaturesBooks(pageNumber: pageNumber);
  if(books.isNotEmpty){
    return right(books);
  }
  books= await homeRemoteDataSource.fetchFeaturesBooks(pageNumber: pageNumber);
  return right(books);
}  catch (e) {
 if(e is DioError){
   return left(ServerFailure.fromDiorError(e));
 }
 return left(ServerFailure(e.toString()));

}

  }

  @override
  Future<Either<Failure, List<BookEntity>>>fetchNewsBook()async {
List <BookEntity>books;
try {
  books=homeLocalDataSource.fetchNewsBooks();
  if(books.isNotEmpty){
    return right(books);
  }
  books= await homeRemoteDataSource.fetchNewsBooks();
  return right(books);
}  catch (e) {
  if(e is DioError){
    return left(ServerFailure.fromDiorError(e));
  }
  return left(ServerFailure(e.toString()));
}
  }

}