import 'package:book_journey/models/book.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  String _status = "Reading";

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Buku")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Judul Buku"),
                validator: (v) => v!.isEmpty ? "Judul wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: "Penulis"),
                validator: (v) => v!.isEmpty ? "Penulis wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                items: ["Reading", "Finished", "To Read"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _status = v!),
                decoration: const InputDecoration(labelText: "Status"),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final book = Book(
                        title: _titleController.text,
                        author: _authorController.text,
                        status: _status,
                      );
                      Navigator.pop(context, book);
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}