import 'package:book_app/features/home/presentation/manger/news_books_cubit/news_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/book_entity.dart';
import 'book_list_view_item.dart';

class NewsBookListView extends StatefulWidget {
  const NewsBookListView({super.key, required this.books});
final List<BookEntity> books;

  @override
  State<NewsBookListView> createState() => _NewsBookListViewState();
}

class _NewsBookListViewState extends State<NewsBookListView> {
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
        await BlocProvider.of<NewsBooksCubit>(context)
            .fetchNewsBook(pageNumber: nextPage++);
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
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BookListViewItem(book :widget.books[index]),
        );
      },
    );
  }
}
