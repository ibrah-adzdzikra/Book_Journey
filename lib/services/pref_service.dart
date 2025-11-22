import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';

class PrefService {
  static const String bookKey = 'books';

  static Future<void> saveBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookList =
        books.map((book) => jsonEncode(book.toMap())).toList();
    prefs.setStringList(bookKey, bookList);
  }

  static Future<List<Book>> loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? bookList = prefs.getStringList(bookKey);

    if (bookList == null) return [];

    return bookList
        .map((item) => Book.fromMap(jsonDecode(item)))
        .toList();
  }
}
