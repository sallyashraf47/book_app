import 'package:flutter/material.dart';

import 'custom_app_bar.dart';
import 'featurd_book.dart';
import 'featured_books_list_view_bloc_builder.dart';
import 'news_book_list_view_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {


    return CustomScrollView(
      slivers:[SliverToBoxAdapter(child:
         Column(
        children: [
          CustomAppBar(),
          FeaturedBooksListViewBlocBuilder(),
        ],

      ),
      ) ,
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child:           NewsBookListViewCubit()

          ),
        ),],
    );
  }
}
