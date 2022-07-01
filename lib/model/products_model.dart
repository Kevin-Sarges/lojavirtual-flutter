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
      // id: snapshot.id,
      // title: data['title'],
      // description: data['description'],
      // price: data['price'],
      // images: data['images'],
      // sizes: data['images'],
      title: data.toString().contains('title') ? snapshot.get('title') : '',
      description: data.toString().contains('description')
          ? snapshot.get('description')
          : '',
      price:
          data.toString().contains('price') ? snapshot.get('price') + 0.0 : 0,
      images: data['images'] is Iterable ? List.from(data['images']) : [],
      sizes: data.toString().contains('sizes') ? snapshot.get('sizes') : [],
    );
  }
}
