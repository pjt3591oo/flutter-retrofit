import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'book.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:3000/book")
abstract class BookClient {
  factory BookClient(Dio dio) = _BookClient;

  @GET("/")
  Future<List<Book>> getBooks();

  @GET("/{id}") 
  Future<Book> getBook(@Path('id') int id);

  @POST("/")
  Future<Book> createBook(@Body() Book book);
}

@JsonSerializable()
class Book {
  String title;
  String author;

  Book({required this.title, required this.author});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}


