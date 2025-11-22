import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'add_book_page.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookService bookService = BookService();

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  void loadBooks() async {
    await bookService.loadData();
    setState(() {});
  }

  void addBook(Book book) async {
    await bookService.addBook(book);
    setState(() {});
  }

  void deleteBook(int index) async {
    await bookService.deleteBook(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Journey'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddBookPage(onAdd: addBook),
            ),
          );
        },
      ),
      body: bookService.books.isEmpty
          ? const Center(child: Text('Belum ada buku'))
          : ListView.builder(
              itemCount: bookService.books.length,
              itemBuilder: (context, index) {
                final book = bookService.books[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(
                        '${book.author} • ${book.year}\nStatus: ${book.status}\nRating: ${book.rating}/5\n${book.note}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteBook(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
