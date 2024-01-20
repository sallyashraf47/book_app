import 'package:book_app/features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/snack_bar.dart';
import '../../../domain/entity/book_entity.dart';
import 'featurd_book.dart';

class FeaturedBooksListViewBlocBuilder extends StatefulWidget {
   const FeaturedBooksListViewBlocBuilder({super.key});

  @override
  State<FeaturedBooksListViewBlocBuilder> createState() => _FeaturedBooksListViewBlocBuilderState();
}

class _FeaturedBooksListViewBlocBuilderState extends State<FeaturedBooksListViewBlocBuilder> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit,FeaturedBooksState>(builder: (context, state) {
      if (state is FeaturedBooksSuccess ||
          state is FeaturedPaginationLoading ||
          state is FeaturedPaginationFailure) {
        return FeaturedBookListView(
          books: books,
        );
      }

     else  if(state is FeaturedBooksFailure){
       return Text(state.msg);
      }
      else {
        return const CircularProgressIndicator();

      }
    }, listener: (BuildContext context, FeaturedBooksState state) {
      if (state is FeaturedBooksSuccess) {
        books.addAll(state.books);
      }

      if (state is FeaturedPaginationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildErrorWidget(state.msg),
        );
      }
    },

    );
  }
}
