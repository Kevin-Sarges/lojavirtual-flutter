// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k3loja/tales/category_tales.dart';

class ProductsTab extends StatelessWidget {
  ProductsTab({Key? key}) : super(key: key);

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: db.collection('products').get(),
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
              var dividedTiles = ListTile.divideTiles(
                tiles: snapshot.data!.docs.map((e) {
                  return CategoryTile(snapshot: e);
                }).toList(),
                color: Colors.grey[500],
              ).toList();

              return ListView(
                children: dividedTiles,
              );
            }
        }
      },
    );
  }
}
