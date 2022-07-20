import 'package:equatable/equatable.dart';

class CartProductModel extends Equatable {
  late String pid;
  late int quantity;
  late String size;
  late double price;
  late String image;

  CartProductModel({
    required this.pid,
    required this.quantity,
    required this.size,
    required this.price,
    required this.image,
  });

  // novo
  CartProductModel.fromJson(Map<String, dynamic> json) {
    json['pid'] = pid;
    json['quantity'] = quantity;
    json['size'] = size;
    json['price'] = price;
    json['image'] = image;
  }

  Map<String, dynamic> toJson() {
    return {
      'pid': pid,
      'quantity': quantity,
      'size': size,
      'price': price,
      'image': image,
    };
  }

  // antes
  toJSONEncodable() {
    Map<String, dynamic> data = {};

    data['pid'] = pid;
    data['quantity'] = quantity;
    data['size'] = size;
    data['price'] = price;
    data['image'] = image;

    return data;
  }

  @override
  List<Object?> get props => [pid, quantity, size, price, image];
}
