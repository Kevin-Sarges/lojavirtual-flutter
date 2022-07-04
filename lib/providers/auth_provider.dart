import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:k3loja/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  late GoogleSignIn googleSignIn;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;
  late SharedPreferences preferences;

  late Status _status = Status.uninitialized;
  Status get status => _status;

  bool isLoaging = false;
  String nameCollection = 'users';

  AuthProvider({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.preferences,
  });

  String? getFirebaseUser() {
    return preferences.getString('id');
  }

  Future<bool> isLoggerIn() async {
    bool isLoggerIn = await googleSignIn.isSignedIn();

    if (isLoaging && preferences.getString('id')?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleGoogleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(nameCollection)
            .where('id', isEqualTo: firebaseUser.uid)
            .get();

        final List<DocumentSnapshot> document = result.docs;
        Map<String, dynamic> userData = {
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "email": firebaseUser.email,
        };

        if (document.isEmpty) {
          firebaseFirestore
              .collection(nameCollection)
              .doc(firebaseUser.uid)
              .set(userData);

          User? currentUser = firebaseUser;

          await preferences.setString('id', currentUser.uid);
          await preferences.setString('name', currentUser.displayName ?? '');
          await preferences.setString('email', currentUser.email ?? '');
        } else {
          DocumentSnapshot documentSnapshot = document[0];

          UserModel userModel = UserModel.fromDocument(documentSnapshot);

          await preferences.setString('id', userModel.id);
          await preferences.setString('name', userModel.name);
          await preferences.setString('email', userModel.email);
          await preferences.setString('address', userModel.address);
          await preferences.setString('password', userModel.password);
        }

        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  Future<void> googleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
