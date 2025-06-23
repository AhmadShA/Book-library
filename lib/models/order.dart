class Order {
  final int bookId;
  final int invoiceId;

  Order({
    required this.bookId,
    required this.invoiceId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      bookId: json['ID_book'] as int,
      invoiceId: json['ID_invoice'] as int,
    );
  }
}
