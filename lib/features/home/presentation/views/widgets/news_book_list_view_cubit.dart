import 'package:book_app/features/home/presentation/manger/news_books_cubit/news_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/snack_bar.dart';
import '../../../domain/entity/book_entity.dart';
import 'news_book_list_view.dart';

class NewsBookListViewCubit extends StatefulWidget {
  const NewsBookListViewCubit({super.key});

  @override
  State<NewsBookListViewCubit> createState() => _NewsBookListViewCubitState();
}

class _NewsBookListViewCubitState extends State<NewsBookListViewCubit> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBooksCubit,NewsBooksState>(builder: (context, state) {

        if(state is NewsBooksSuccess){
         return NewsBookListView(books:books);}
        else if (state is NewsBooksFailure){
          return Text(state.msg);
        }
        else {
          return CircularProgressIndicator();
        }
    },  listener: (context, state) {
      if (state is NewsBooksSuccess) {
        books.addAll(state.books);
      }

      if (state is NewsBooksFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildErrorWidget(state.msg),
        );
      }
    },);
  }
}
