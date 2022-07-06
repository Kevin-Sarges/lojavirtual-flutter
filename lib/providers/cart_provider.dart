import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:k3loja/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  User? firebaseUser;
  List<CartProductModel> products = [];

  CartProvider({this.firebaseUser});

  void addCartItem(CartProductModel cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProductModel cartProduct) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }
}
