import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  final FirebaseFirestore db = FirebaseFirestore.instance;

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

  Future<QuerySnapshot> getImageHome() async {
    final getData = db.collection('home').orderBy('pos').get();

    return getData;
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
                      return createTaleHome(context, snapshot);
                    }
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget createTaleHome(BuildContext context, AsyncSnapshot snapshot) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image:
                'https://images.pexels.com/photos/1311590/pexels-photo-1311590.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
    // return SliverGrid(
    //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 200.0,
    //     crossAxisSpacing: 1,
    //     mainAxisSpacing: 1,
    //     childAspectRatio: 2,
    //   ),
    //   delegate: SliverChildBuilderDelegate(
    //     (context, index) {
    //       print(snapshot.data['image'].toString());

    //       return FadeInImage.memoryNetwork(
    //         placeholder: kTransparentImage,
    //         image: 'https://images.pexels.com/photos/1311590/pexels-photo-1311590.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //         fit: BoxFit.cover,
    //       );
    //     },
    //   ),
    // );
  }
}
