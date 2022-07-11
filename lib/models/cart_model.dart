import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k3loja/models/products_model.dart';

class CartProductModel {
  late String cid;
  late String category;
  late String pid;
  late int quantity;
  late String size;
  late ProductModel productModel;

  CartProductModel();

  CartProductModel.formDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    cid = document.id;
    category = data['category'] ?? '';
    pid = data['pid'] ?? '';
    quantity = data['quantity'] ?? 0;
    size = data['size'] ?? '';
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
