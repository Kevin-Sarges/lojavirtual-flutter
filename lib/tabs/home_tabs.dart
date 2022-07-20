import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:k3loja/providers/auth_provider.dart';
import 'package:k3loja/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  late AuthProvider authProvider;

  final Widget _buildBodyBack = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF048D5C),
          Color(0xFF047D8D),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );

  Future<QuerySnapshot> getImageHome() {
    return db.collection('home').orderBy('pos').get();
  }

  Future<void> googleSignOut() async {
    authProvider.googleSignOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBodyBack,
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('Novidades'),
                centerTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () => googleSignOut(),
                  icon: const Icon(Icons.logout),
                ),
              ],
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
