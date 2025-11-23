class Book {
  int? id;
  String title;
  String author;
  String status;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'status': status,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      status: map['status'],
    );
  }
}