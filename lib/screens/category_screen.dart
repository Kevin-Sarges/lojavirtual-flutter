// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k3loja/models/products_model.dart';
import 'package:k3loja/tales/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen({Key? key, required this.snapshot}) : super(key: key);

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get('title')),
          centerTitle: true,
          backgroundColor: primaryColor,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: db
              .collection('products')
              .doc(snapshot.id)
              .collection('items')
              .get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Container();
                } else {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.all(4),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductModel data = ProductModel.fromDocument(
                            snapshot.data!.docs[index],
                          );
                          data.category = this.snapshot.id;

                          return ProductTile(
                            typeList: 'grid',
                            product: data,
                          );
                        },
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(4),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductModel data = ProductModel.fromDocument(
                            snapshot.data!.docs[index],
                          );
                          data.category = this.snapshot.id;

                          return ProductTile(
                            typeList: 'list',
                            product: data,
                          );
                        },
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
