// ignore_for_file: unused_element
import 'dart:async';
import 'dart:convert';

import 'package:k3loja/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cartListKey = 'cart_products';

class CartProvider extends Model {
  // novo
  SharedPreferences? sharedPreferences;
  int? deleteProductIndex;
  CartProductModel? deletedProduct;
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
    notifyListeners();
  }

  void onDelete(CartProductModel product) {
    return notifyListeners();
  }

  // antes
  // late LocalStorage storage;
  // List<CartProductModel> itemsCart = [];

  // toJSONEncodable() {
  //   List listProduct = itemsCart.map((e) {
  //     return e.toJSONEncodable();
  //   }).toList();

  //   return listProduct;
  // }

  // saveToStorage() {
  //   storage.setItem('items', toJSONEncodable());
  // }

  // addProductCart(
  //   String pid,
  //   int quantity,
  //   String size,
  //   double price,
  //   String image,
  // ) {
  //   final product = CartProductModel(
  //     pid: pid,
  //     quantity: quantity,
  //     size: size,
  //     price: price,
  //     image: image,
  //   );

  //   itemsCart.add(product);
  //   saveToStorage();
  //   notifyListeners();
  // }

  // deleteItemsCart(String pid) async {
  //   await storage.deleteItem(pid);
  // }

  // clearCart() async {
  //   await storage.clear();

  //   itemsCart = storage.getItem('items') ?? [];
  // }
}
