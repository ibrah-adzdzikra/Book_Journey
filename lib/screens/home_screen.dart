import 'package:book_journey/models/book.dart';
import 'package:book_journey/screens/add_book_screen.dart';
import 'package:book_journey/services/auth_service.dart';
import 'package:book_journey/services/database_helper.dart';
import 'package:book_journey/providers/theme_provider.dart';
import 'package:book_journey/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> _books = [];
  bool _isLoading = true;
  String _weather = "Mencari lokasi...";

  @override
  void initState() {
    super.initState();
    // Memanggil data setelah frame pertama selesai agar Provider tersedia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBooks();
      _initLocationAndWeather();
    });
  }

  Future<void> _initLocationAndWeather() async {
    try {
      final weatherService = Provider.of<WeatherService>(context, listen: false);
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || 
          permission == LocationPermission.always) {
        
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low
        );

        final weather = await weatherService.fetchWeather(
          position.latitude, 
          position.longitude
        );

        if (mounted) setState(() => _weather = weather);
      } else {
        setState(() => _weather = "Izin lokasi ditolak");
      }
    } catch (e) {
      setState(() => _weather = "Gagal akses GPS");
    }
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

  Future<void> _addBook(Book book) async {
    final db = Provider.of<DatabaseHelper>(context, listen: false);
    await db.insertBook(book);
    _loadBooks();
  }

  Future<void> _deleteBook(int id) async {
    final db = Provider.of<DatabaseHelper>(context, listen: false);
    await db.deleteBook(id);
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Book Journey"),
            Text(
              "Cuaca di lokasi Anda: $_weather",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => themeProvider.toggleTheme(),
            icon: const Icon(Icons.brightness_6),
          ),
          IconButton(
            onPressed: () async {
              await authService.logout();
              if (mounted) Navigator.of(context).pushReplacementNamed('/login');
            },
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
          if (result != null) _addBook(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}