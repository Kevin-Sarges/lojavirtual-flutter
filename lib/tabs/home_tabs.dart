// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  FirebaseFirestore db = FirebaseFirestore.instance;

  final Widget _buildBodyBack = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 211, 118, 130),
          Color.fromARGB(255, 211, 181, 168),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );

  Future<QuerySnapshot> getImageHome() {
    return db.collection('home').orderBy('pos').get();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBodyBack,
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Novidades'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: getImageHome(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return SliverToBoxAdapter(
                        child: GridView.custom(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            repeatPattern: QuiltedGridRepeatPattern.inverted,
                            pattern: snapshot.data!.docs.map((e) {
                              return QuiltedGridTile(
                                e['x'],
                                e['y'],
                              );
                            }).toList(),
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            (context, index) => FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: snapshot.data!.docs[index]['image'],
                              fit: BoxFit.cover,
                            ),
                            childCount: snapshot.data!.docs.length,
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
