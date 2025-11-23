import 'package:book_journey/models/book.dart';
import 'package:book_journey/screens/add_book_screen.dart';
import 'package:book_journey/services/auth_service.dart';
import 'package:book_journey/services/database_helper.dart';
import 'package:book_journey/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Book> _books;
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

  Future<void> _addBook(Book book) async {
    await _db.insertBook(book);
    _loadBooks();
  }

  Future<void> _deleteBook(int id) async {
    await _db.deleteBook(id);
    _loadBooks();
  }

  Future<void> _toggleTheme() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await themeProvider.toggleTheme();
    // Tidak perlu navigasi ulang! UI otomatis update karena notifyListeners()
  }

  Future<void> _logout() async {
    await AuthService().logout();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Journey"),
        actions: [
          IconButton(
            onPressed: _toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_books.isEmpty
              ? const Center(child: Text("Belum ada buku"))
              : ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text("oleh ${book.author} • ${book.status}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteBook(book.id!),
                        ),
                      ),
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBookScreen()),
          );
          if (result != null) {
            _addBook(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}