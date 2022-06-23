import 'package:cloud_firestore/cloud_firestore.dart';

class ImageHomeModels {
  final String? image;
  final int? pos;
  final int? x;
  final int? y;
  
  ImageHomeModels({
    this.image,
    this.pos,
    this.x,
    this.y,
  });

  factory ImageHomeModels.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ImageHomeModels(
      image: data?['image'],
      pos: data?['pos'],
      x: data?['x'],
      y: data?['y'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (image != null) "image": image,
      if (pos != null) "pos": pos,
      if (x != null) "x": x,
      if (y != null) "y": y,
    };
  }
}
