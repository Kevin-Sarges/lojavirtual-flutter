// ignore_for_file: no_logic_in_create_state, unused_local_variable

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k3loja/models/cart_model.dart';
import 'package:k3loja/models/products_model.dart';
import 'package:k3loja/providers/cart_provider.dart';
import 'package:k3loja/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;

  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductModel product;
  final CarouselController _carouselController = CarouselController();
  final CartProvider provider = CartProvider();

  String? size;
  int quantity = 0;
  int _current = 0;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title.toString()),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 0.9,
                child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: product.images!.map((url) {
                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: product.images!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : primaryColor)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes!.map((e) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            size = e;
                          });
                        },
                        child: Container(
                          width: 2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            border: Border.all(
                              color: e != size ? Colors.grey : primaryColor,
                              width: 3,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(e),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Escolha a quantidade que deseja: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: quantity > 0
                          ? () {
                              setState(() {
                                quantity--;
                              });
                            }
                          : null,
                      icon: const Icon(
                        Icons.remove,
                      ),
                      color: Colors.red[600],
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                      color: primaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ScopedModelDescendant<CartProvider>(
                    builder: (context, child, model) {
                      return ElevatedButton(
                        onPressed: quantity > 0
                            ? () {
                                var cartItem = model.productsCart;

                                CartProductModel newProduct = CartProductModel(
                                  pid: product.id!,
                                  quantity: quantity,
                                  size: size!,
                                  price: product.price!,
                                  image: product.images![1],
                                );

                                cartItem.add(newProduct);

                                model.saveProductCart(cartItem);
                                print(cartItem);

                                Fluttertoast.showToast(
                                  msg: 'Adcionado ao carrion !!',
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            : null,
                        child: const Text(
                          'Adicionar ao Carrinho',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.description.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
