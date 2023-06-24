import 'dart:convert';

import 'package:flutter/services.dart';

class Contactmodel {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? dob;
  Contactmodel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.dob,
  });

  Contactmodel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? dob,
  }) {
    return Contactmodel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob,
    };
  }

  factory Contactmodel.fromMap(Map<String, dynamic> map) {
    return Contactmodel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      dob: map['dob'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Contactmodel.fromJson(String source) =>
      Contactmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contactmodel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, dob: $dob)';
  }

  @override
  bool operator ==(covariant Contactmodel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        dob.hashCode;
  }

  static List<Contactmodel> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<Contactmodel>((e) => Contactmodel.fromMap(e)).toList();
  }

  static Future<List<Contactmodel>> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');

    List<Contactmodel> newDatas =
        Contactmodel.fromListDynamic(json.decode(response));
    return newDatas;
  }
}
