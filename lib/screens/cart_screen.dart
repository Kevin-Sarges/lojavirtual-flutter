import 'package:flutter/material.dart';
import 'package:k3loja/models/cart_model.dart';
import 'package:k3loja/providers/cart_provider.dart';
import 'package:localstorage/localstorage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final SizedBox _sizedHeight = const SizedBox(height: 10);
  final SizedBox _sizedWidth = const SizedBox(width: 20);
  final LocalStorage storage = LocalStorage('cart_products');
  final CartProvider list = CartProvider(
    storage: LocalStorage('cart_products'),
  );
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder(
          future: storage.ready,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!initialized) {
              var item = storage.getItem('items');

              if (item != null) {
                list.itemsCart = List<CartProductModel>.from(
                  (item as List).map(
                    (e) => CartProductModel(
                      pid: e['pid'],
                      quantity: e['quantity'],
                      size: e['size'],
                      price: e['price'],
                      image: e['image'],
                    ),
                  ),
                );
              }

              print(item);
              initialized = true;
            }

            List<Widget> listProductCart = list.itemsCart.map(
              (e) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.network(
                        e.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Camiseta',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tamanho: ${e.size}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _sizedHeight,
                        Row(
                          children: [
                            Text(
                              'R\$ ${e.price}',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            _sizedWidth,
                            Text(
                              'Quantidade: ${e.quantity}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            _sizedHeight,
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              list.deleteItemsCart(e.pid);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                          ),
                          child: Row(
                            children: [
                              const Text('Remover do Carrinho'),
                              _sizedWidth,
                              const Icon(Icons.remove_shopping_cart),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ).toList();

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: listProductCart,
            );
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Valor total da compra: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ 19.99',
                      style: TextStyle(
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
                        setState(() {
                          list.clearCart();
                        });
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
  }
}
