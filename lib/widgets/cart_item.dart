import 'package:flutter/material.dart';
import 'package:k3loja/models/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product, required this.onDelete})
      : super(key: key);

  final CartProductModel product;
  final Function(CartProductModel) onDelete;
  final SizedBox _sizedHeight = const SizedBox(height: 10);
  final SizedBox _sizedWidth = const SizedBox(width: 20);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Image.network(
            product.image,
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
              'Tamanho: ${product.size}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            _sizedHeight,
            Row(
              children: [
                Text(
                  'R\$ ${product.price}',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                _sizedWidth,
                Text(
                  'Quantidade: ${product.quantity}',
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
                onDelete(product);
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
  }
}
