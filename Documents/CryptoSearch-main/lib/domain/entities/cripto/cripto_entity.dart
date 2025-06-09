final class CriptoEntity {
  final String symbol;
  final String name;
  final String slug;
  final double price;
  final double percentChange24h;
  final double percentChange7d;
  final double percentChange30d;
  final DateTime dateAdded;

  const CriptoEntity({
    required this.symbol,
    required this.name,
    required this.slug,
    required this.price,
    required this.percentChange24h,
    required this.percentChange7d,
    required this.percentChange30d,
    required this.dateAdded,
  });

  factory CriptoEntity.fromJson(Map<String, dynamic> json) {
    final usd = json['quote']?['USD'] ?? {};

    return CriptoEntity(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      price: (usd['price'] ?? 0).toDouble(),
      percentChange24h: (usd['percent_change_24h'] ?? 0).toDouble(),
      percentChange7d: (usd['percent_change_7d'] ?? 0).toDouble(),
      percentChange30d: (usd['percent_change_30d'] ?? 0).toDouble(),
      dateAdded: DateTime.tryParse(json['date_added'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'slug': slug,
      'quote': {
        'USD': {
          'price': price,
          'percent_change_24h': percentChange24h,
          'percent_change_7d': percentChange7d,
          'percent_change_30d': percentChange30d,
        },
      },
    };
  }
}
