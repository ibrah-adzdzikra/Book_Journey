import 'package:flutter/material.dart';
import '../models/book.dart';

class AddBookPage extends StatefulWidget {
  final Function(Book) onAdd;

  const AddBookPage({super.key, required this.onAdd});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final yearController = TextEditingController();
  final noteController = TextEditingController();

  String status = 'Belum Dibaca';
  int rating = 3;

  void saveBook() {
    final book = Book(
      title: titleController.text,
      author: authorController.text,
      year: yearController.text,
      status: status,
      rating: rating,
      note: noteController.text,
    );
    widget.onAdd(book);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Buku')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul Buku'),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Penulis'),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Tahun Terbit'),
            ),
            DropdownButtonFormField(
              value: status,
              items: const [
                DropdownMenuItem(
                    value: 'Belum Dibaca', child: Text('Belum Dibaca')),
                DropdownMenuItem(
                    value: 'Sudah Dibaca', child: Text('Sudah Dibaca')),
              ],
              onChanged: (value) {
                setState(() {
                  status = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 10),
            Text('Rating: $rating'),
            Slider(
              value: rating.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: rating.toString(),
              onChanged: (value) {
                setState(() {
                  rating = value.toInt();
                });
              },
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Catatan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveBook,
              child: const Text('Simpan Buku'),
            ),
          ],
        ),
      ),
    );
  }
}
