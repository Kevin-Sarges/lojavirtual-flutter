// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:k3loja/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final LocalStorage storage;
  List<CartProductModel> itemsCart = [];

  CartProvider({required this.storage});

  toJSONEncodable() {
    return itemsCart.map((e) {
      return e.toJSONEncodable();
    }).toList();
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

  getItemsCart() {
    List product = storage.getItem('items');

    print(product.toList());

    return product;
  }

  clearCart() async {
    await storage.clear();

    itemsCart = storage.getItem('items') ?? [];
  }
}
