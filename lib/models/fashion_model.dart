// lib/models/fashion_model.dart

class ProductModel {
  final int id;  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final String returnPolicy;
  final List<String> images;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.images,
    required this.thumbnail,
  });

  // Factory constructor to create a ProductModel from a map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      price: (map['price'] as num).toDouble(),
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      stock: map['stock'],
      tags: List<String>.from(map['tags']),
      brand: map['brand'],
      sku: map['sku'],
      warrantyInformation: map['warrantyInformation'],
      shippingInformation: map['shippingInformation'],
      availabilityStatus: map['availabilityStatus'],
      returnPolicy: map['returnPolicy'],
      images: List<String>.from(map['images']),
      thumbnail: map['thumbnail'],
    );
  }
}
