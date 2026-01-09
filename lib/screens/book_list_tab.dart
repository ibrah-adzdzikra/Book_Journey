import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/database_helper.dart';
import 'add_book_screen.dart';

class BookListTab extends StatefulWidget {
  const BookListTab({super.key});

  @override
  State<BookListTab> createState() => _BookListTabState();
}

class _BookListTabState extends State<BookListTab> {
  List<Book> _books = [];
  bool _isLoading = true;
  final _db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final books = await _db.getBooks();
    if (mounted) {
      setState(() {
        _books = books;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteBook(int id) async {
    await _db.deleteBook(id);
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _books.isEmpty
              ? const Center(child: Text("Belum ada buku"))
              : ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${book.author} • ${book.status}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteBook(book.id!),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBookScreen()),
          );
          if (result != null) {
            await _db.insertBook(result);
            _loadBooks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}