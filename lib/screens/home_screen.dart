import 'package:flutter/material.dart';

import '../tabs/home_tabs.dart';
import '../tabs/products_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomeDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Categorias'),
            centerTitle: true,
            backgroundColor: primaryColor,
          ),
          drawer: CustomeDrawer(pageController: _pageController),
          body: ProductsTab(),
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }
}
