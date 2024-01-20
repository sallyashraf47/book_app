import 'package:bloc/bloc.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/book_entity.dart';

part 'news_books_state.dart';

class NewsBooksCubit extends Cubit<NewsBooksState> {
  NewsBooksCubit(this.homeRepo) : super(NewsBooksInitial());
  final HomeRepo homeRepo;
  Future<void> fetchNewsBook({int pageNumber=0})async {
    if(pageNumber==0){
      emit(NewsBooksLoading());
    }
  else{
      emit(NewsNewsPaginationLoading());

    }
    var result = await homeRepo.fetchNewsBook();
   result.fold((failure) {
     if(pageNumber==0){
       emit(NewsBooksFailure(failure.message));

     }
     else{
       emit(NewsPaginationFailure(failure.message));
     }
   }, (books) {
     emit(NewsBooksSuccess(books));
   });
  }
}
