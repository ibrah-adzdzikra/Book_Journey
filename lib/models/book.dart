class Book {
  String title;
  String author;
  String year;
  String status;
  int rating;
  String note;

  Book({
    required this.title,
    required this.author,
    required this.year,
    required this.status,
    required this.rating,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'year': year,
      'status': status,
      'rating': rating,
      'note': note,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'],
      author: map['author'],
      year: map['year'],
      status: map['status'],
      rating: map['rating'],
      note: map['note'],
    );
  }
}
