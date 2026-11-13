class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'] is Map
        ? json['rating'] as Map
        : <String, dynamic>{};

    final image = json['image']?.toString() ?? '';

    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? 'Unknown Product',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Unknown',
      imageUrl: image,
      rating: (ratingData['rate'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (ratingData['count'] as num?)?.toInt() ?? 0,
      images: [
        if (image.isNotEmpty) image,
      ],
    );
  }
}