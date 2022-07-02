import 'package:flutter/material.dart';
import 'package:k3loja/screens/login_screen.dart';

import '../tales/drawer_tiles.dart';

class CustomeDrawer extends StatelessWidget {
  CustomeDrawer({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  final Widget _buildDrawerBack = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 203, 236, 241),
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack,
          ListView(
            padding: const EdgeInsets.only(left: 23, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        'Loja\nVirtual',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Olá,',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              'Entre ou Cadastre-se >',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(
                icon: Icons.home,
                text: 'início',
                controller: pageController,
                page: 0,
              ),
              DrawerTile(
                icon: Icons.list,
                text: 'Produtos',
                controller: pageController,
                page: 1,
              ),
              DrawerTile(
                icon: Icons.location_on,
                text: 'Lojas',
                controller: pageController,
                page: 2,
              ),
              DrawerTile(
                icon: Icons.playlist_add_check,
                text: 'Meus Pedidos',
                controller: pageController,
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
