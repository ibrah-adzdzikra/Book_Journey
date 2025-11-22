import '../models/book.dart';
import 'pref_service.dart';

class BookService {
  List<Book> books = [];

  Future<void> loadData() async {
    books = await PrefService.loadBooks();
  }

  Future<void> addBook(Book book) async {
    books.add(book);
    await PrefService.saveBooks(books);
  }

  Future<void> deleteBook(int index) async {
    books.removeAt(index);
    await PrefService.saveBooks(books);
  }
}
