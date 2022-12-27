// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:docki/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  final String id;
  final String name;
  final String email;

  const AuthUserModel({
    required this.id,
    required this.name,
    required this.email,
  }) : super(
          id: id,
          name: name,
          email: email,
        );

  factory AuthUserModel.fromMap(Map<String, dynamic> data) {
    return AuthUserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
    );
  }

  factory AuthUserModel.fromJson(String source) {
    final data = json.decode(source);

    return AuthUserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
    );
  }

  String get toJson {
    return json.encode({
      'id': id,
      'name': name,
      'email': email,
    });
  }
}
