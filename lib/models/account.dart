/// Клас сутності рахунку - описує дані про рахунок та бюджет користувача
final class Account {
  final String id;
  final String title;
  final String currency;
  final double? budget;
  final String userId;

  const Account({
    required this.id,
    required this.title,
    required this.currency,
    required this.budget,
    required this.userId,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json['id'] as String,
        title: json['title'] as String,
        currency: json['currency'] as String,
        budget: json['budget'] as double?,
        userId: json['userId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'currency': currency,
        'budget': budget,
        'userId': userId,
      };

  copyWith({
    String? id,
    String? title,
    String? currency,
    double? budget,
    String? userId,
  }) {
    return Account(
      id: id ?? this.id,
      title: title ?? this.title,
      currency: currency ?? this.currency,
      budget: budget ?? this.budget,
      userId: userId ?? this.userId,
    );
  }
}
