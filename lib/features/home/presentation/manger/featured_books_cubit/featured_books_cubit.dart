import 'package:bloc/bloc.dart';
import 'package:book_app/core/errors/failure.dart';
import 'package:book_app/features/home/domain/entity/book_entity.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());
  final HomeRepo homeRepo;
 fetchFeaturesBooks({int pageNumber=0})async{
   if(pageNumber==0){
     emit(FeaturedBooksLoading());

   }
   else{
     emit(FeaturedPaginationLoading());
   }
   var result= await homeRepo.fetchFeaturesBook(pageNumber: pageNumber);
   result.fold((failure) {
     if(pageNumber==0) {
       emit(FeaturedBooksFailure(failure.message));
     }
     else{
       emit(FeaturedPaginationFailure(failure.message));
     }
     }, (books) {
     emit(FeaturedBooksSuccess(books));
   });

 }
}
