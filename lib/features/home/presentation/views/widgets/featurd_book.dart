import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/book_entity.dart';
import '../../manger/featured_books_cubit/featured_books_cubit.dart';
import 'custom_book_image.dart';

class FeaturedBookListView extends StatefulWidget {
  final List<BookEntity> books;
  const FeaturedBookListView({super.key, required this.books});

  @override
  State<FeaturedBookListView> createState() => _FeaturedBookListViewState();
}

class _FeaturedBookListViewState extends State<FeaturedBookListView> {
  late final ScrollController _scrollController;
  var nextPage = 1;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }
  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<FeaturedBooksCubit>(context)
            .fetchFeaturesBooks(pageNumber: nextPage++);
        isLoading = false;
      }
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return SizedBox(      height: MediaQuery.of(context).size.height * .3,

      child: ListView.builder(
      scrollDirection: Axis.horizontal,
controller: _scrollController,
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomBookImage(
          image: widget.books[index].image ?? '',
        ),
      );
    },),);
  }
}
