class Invoice {
  final int userId;
  final DateTime date;
  final double total;
  final String creditCard;

  Invoice({
    required this.userId,
    required this.date,
    required this.total,
    required this.creditCard,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      userId: json['ID_user'] as int,
      date: DateTime.parse(json['Date'] as String),
      total: json['Total'] as double,
      creditCard: json['CreditCard'] as String,
    );
  }
}
