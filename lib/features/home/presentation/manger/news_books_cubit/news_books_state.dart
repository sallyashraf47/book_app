part of 'news_books_cubit.dart';

@immutable
abstract class NewsBooksState {}

class NewsBooksInitial extends NewsBooksState {}
class NewsBooksLoading extends NewsBooksState {}
class NewsNewsPaginationLoading extends NewsBooksState {}

class NewsBooksSuccess extends NewsBooksState {
  final List <BookEntity>books;

  NewsBooksSuccess(this.books);

}
class NewsBooksFailure extends NewsBooksState {
  final String msg;

  NewsBooksFailure(this.msg);

}class NewsPaginationFailure extends NewsBooksState {
  final String msg;

  NewsPaginationFailure(this.msg);

}
