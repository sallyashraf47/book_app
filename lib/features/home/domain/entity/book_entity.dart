

import 'package:hive/hive.dart';
part  'book_entity.g.dart';
@HiveType(typeId: 1)

class BookEntity {
 @HiveField(0)

 final String bookId;
 @HiveField(1)

 final String? image;
 @HiveField(2)

 final String? authorName;
 @HiveField(3)

 final String title;
 @HiveField(4)

 final num? price;
 @HiveField(5)

 final num? rating;

  BookEntity({this.image, required this.title, this.price,  this.authorName,
      required this.bookId, this.rating});
}
