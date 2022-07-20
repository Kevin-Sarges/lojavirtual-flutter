import 'package:flutter/material.dart';
import 'package:k3loja/models/cart_model.dart';
import 'package:k3loja/providers/cart_provider.dart';
import 'package:k3loja/widgets/cart_item.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final SizedBox _sizedHeight = const SizedBox(height: 10);

  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartProvider>(
      builder: (context, child, model) {
        return Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder(
              future: model.getProductListCart(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        children: [
                          for (CartProductModel product in model.productsCart)
                            CartItem(
                              product: product,
                              onDelete: model.onDelete,
                            )
                        ],
                      );
                    } else {
                      return ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        children: [
                          for (CartProductModel product in model.productsCart)
                            CartItem(
                              product: product,
                              onDelete: model.onDelete,
                            )
                        ],
                      );
                    }
                }
              },
            ),
            Positioned(
              height: 100,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Valor total da compra: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R\$ ${model.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF048D5C),
                          ),
                        ),
                      ],
                    ),
                    _sizedHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            model.clearCart();
                          },
                          child: const Text(
                            'Limpar carriho',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Comprar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF048D5C),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
