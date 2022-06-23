import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k3loja/models/image_home_models.dart';

class ImageHomeProvider {
  final FirebaseFirestore firebaseFirestore;

  ImageHomeProvider(this.firebaseFirestore);

  void getHomeImage() async {
    final ref = firebaseFirestore.collection('home').doc('image').withConverter(
          fromFirestore: ImageHomeModels.fromFirestore,
          toFirestore: (ImageHomeModels image, _) => image.toFirestore(),
        );
    final docSnap = await ref.get();
    final image = docSnap.data();

    if (image != null) {
      print(image);
    } else {
      print('error');
    }
  }
}
