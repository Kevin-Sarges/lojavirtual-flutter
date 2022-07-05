// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserModel extends Equatable {
  late String id;
  late String name;
  late String password;
  late String address;
  late String email;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.address,
    required this.email,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? password,
    String? address,
    String? email,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
        address: address ?? this.address,
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() => {
        name: name,
        password: password,
        email: email,
        address: address,
      };

  factory UserModel.fromDocument(DocumentSnapshot snapshot) {
    String name = '';
    String password = '';
    String address = '';
    String email = '';

    try {
      name = snapshot.get('name');
      email = snapshot.get('email');
      password = snapshot.get('password');
      address = snapshot.get('address');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return UserModel(
      id: snapshot.id,
      name: name,
      password: password,
      address: address,
      email: email,
    );
  }

  @override
  List<Object?> get props => [id, name, email, password, address];
}
