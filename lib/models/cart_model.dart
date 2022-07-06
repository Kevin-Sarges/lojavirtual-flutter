import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k3loja/models/products_model.dart';

class CartProductModel {
  late String cid;
  final String category;
  final String pid;
  final int quantity;
  final String size;
  late ProductModel productModel;

  CartProductModel({
    required this.cid,
    required this.category,
    required this.pid,
    required this.quantity,
    required this.size,
  });

  factory CartProductModel.formDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return CartProductModel(
      cid: document.id,
      category: data['category'] ?? '',
      pid: data['pid'] ?? '',
      quantity: data['quantity'] ?? 0,
      size: data['size'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productModel.toResumeMap(),
    };
  }
}
