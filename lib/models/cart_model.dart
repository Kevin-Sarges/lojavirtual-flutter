class CartProductModel {
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

  toJSONEncodable() {
    Map<String, dynamic> data = {};

    data['pid'] = pid;
    data['quantity'] = quantity;
    data['size'] = size;
    data['price'] = price;
    data['image'] = image;

    return data;
  }
}
