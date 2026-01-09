// lib/screens/book_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/database_helper.dart';
import 'add_book_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final db = Provider.of<DatabaseHelper>(context, listen: false);
    final books = await db.getBooks();
    if (mounted) {
      setState(() {
        _books = books;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_books.isEmpty
              ? const Center(child: Text("Belum ada buku di koleksi kamu."))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(Icons.book, color: Colors.blue[800]),
                        ),
                        title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${book.author} • ${book.status}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () async {
                            await Provider.of<DatabaseHelper>(context, listen: false).deleteBook(book.id!);
                            _loadBooks();
                          },
                        ),
                      ),
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBookScreen()),
          );
          if (result != null) {
            await Provider.of<DatabaseHelper>(context, listen: false).insertBook(result);
            _loadBooks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}