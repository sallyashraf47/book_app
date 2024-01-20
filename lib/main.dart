import 'package:book_app/core/api_services.dart';
import 'package:book_app/features/home/data/data_source/home_local_data_source.dart';
import 'package:book_app/features/home/data/data_source/home_remote_data_sourse.dart';
import 'package:book_app/features/home/data/repos/home_repo_impl.dart';
import 'package:book_app/features/home/domain/entity/book_entity.dart';
import 'package:book_app/features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:book_app/features/home/presentation/manger/news_books_cubit/news_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'core/utils/setup_service_locator.dart';
import 'core/utils/simpel_bloc_observer.dart';
import 'features/home/presentation/views/home_view.dart';

void main()async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
 await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);
  setupServiceLocator();

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return FeaturedBooksCubit(getIt.get<HomeRepoImpl>(),)..fetchFeaturesBooks();
        },),
        BlocProvider(create: (context) {

          return NewsBooksCubit(getIt.get<HomeRepoImpl>())..fetchNewsBook();
        },)
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
        theme:  ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: kPrimaryColor),
        scaffoldBackgroundColor: kPrimaryColor,
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BookApp(),
      ),
    );
  }
}
class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}


