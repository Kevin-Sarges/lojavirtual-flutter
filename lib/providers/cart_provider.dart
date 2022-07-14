// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:k3loja/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final LocalStorage storage;
  List<CartProductModel> itemsCart = [];

  CartProvider({required this.storage});

  toJSONEncodable() {
    List listProduct = itemsCart.map((e) {
      return e.toJSONEncodable();
    }).toList();

    return listProduct;
  }

  saveToStorage() {
    storage.setItem('items', toJSONEncodable());
  }

  addProductCart(
    String pid,
    int quantity,
    String size,
    double price,
    String image,
  ) {
    final product = CartProductModel(
      pid: pid,
      quantity: quantity,
      size: size,
      price: price,
      image: image,
    );

    itemsCart.add(product);
    saveToStorage();
    notifyListeners();
  }

  deleteItemsCart(String pid) async {
    await storage.deleteItem(pid);
  }

  clearCart() async {
    await storage.clear();

    itemsCart = storage.getItem('items') ?? [];
  }
}
