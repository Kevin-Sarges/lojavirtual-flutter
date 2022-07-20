// ignore_for_file: unused_element
import 'dart:async';
import 'dart:convert';

import 'package:k3loja/models/cart_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cartListKey = 'cart_item';

class CartProvider extends Model {
  // novo
  LocalStorage? storage = LocalStorage('cart_products');
  SharedPreferences? sharedPreferences;
  int? deleteProductIndex;
  CartProductModel? deletedProduct;
  double totalPrice = 0;
  List<CartProductModel> productsCart = [];

  Future<List<CartProductModel>> getProductListCart() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences?.getString(cartListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded.map((e) => CartProductModel.fromJson(e)).toList();
  }

  void saveProductCart(List<CartProductModel> items) {
    final String jsonString = json.encode(items);

    sharedPreferences?.setString(cartListKey, jsonString);
    storage?.setItem(cartListKey, jsonString);
    notifyListeners();
  }

  void onDelete(CartProductModel product) {
    deletedProduct = product;
    deleteProductIndex = productsCart.indexOf(product);

    totalPrice = totalPrice - (product.quantity * product.price);

    productsCart.remove(product);
    saveProductCart(productsCart);
  }

  void clearCart() async {
    await storage?.clear();

    productsCart.clear();
    productsCart = storage?.getItem('items') ?? [];
    saveProductCart(productsCart);
  }
}
