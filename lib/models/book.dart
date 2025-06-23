class Book {
  final String title;
  final String type;
  final double price;
  final int authorId;

  Book({
    required this.title,
    required this.type,
    required this.price,
    required this.authorId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['Title'] as String,
      type: json['Type'] as String,
      price: json['Price'] as double,
      authorId: json['ID_author'] as int,
    );
  }
}
