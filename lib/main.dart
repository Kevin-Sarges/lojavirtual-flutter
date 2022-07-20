// ignore_for_file: must_be_immutable

import 'package:k3loja/providers/cart_provider.dart';
import 'package:k3loja/screens/splash_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:k3loja/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    preferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.preferences}) : super(key: key);

  final SharedPreferences preferences;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late User? firebaseUser;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartProvider>(
      model: CartProvider(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
              googleSignIn: GoogleSignIn(),
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: firebaseFirestore,
              preferences: preferences,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Loja demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
