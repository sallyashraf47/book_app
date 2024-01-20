part of 'featured_books_cubit.dart';

@immutable
abstract class FeaturedBooksState {}

class FeaturedBooksInitial extends FeaturedBooksState {}
class FeaturedBooksLoading extends FeaturedBooksState {}
class FeaturedPaginationLoading extends FeaturedBooksState {}
class FeaturedBooksSuccess extends FeaturedBooksState {
  final List <BookEntity>books;

  FeaturedBooksSuccess(this.books);
}
class FeaturedBooksFailure extends FeaturedBooksState {
  final String msg;

  FeaturedBooksFailure(this.msg);
}class FeaturedPaginationFailure extends FeaturedBooksState {
  final String msg;

  FeaturedPaginationFailure(this.msg);
}
