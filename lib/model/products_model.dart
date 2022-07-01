import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String? category;
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final List? images;
  final List? sizes;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.images,
    this.sizes,
  });

  factory ProductModel.fromDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ProductModel(
      id: snapshot.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0,
      images: data['images'] is Iterable ? List.from(data['images']) : [],
      sizes: data['sizes'] is Iterable ? List.from(data['sizes']) : [],
    );
  }
}
