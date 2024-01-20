import 'package:book_app/core/errors/failure.dart';
import 'package:book_app/features/home/domain/entity/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo{
  Future<Either<Failure, List<BookEntity>>> fetchFeaturesBook({int pageNumber=0});
  Future<Either<Failure, List<BookEntity>>> fetchNewsBook();
}