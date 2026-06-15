import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/general/services/keywords_builder.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final List<String>? keywords;
  final Timestamp? createdAt;
  Timestamp? updatedAt;
  final String? fcmToken;
  UserModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.keywords,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : null,
      updatedAt: map['updatedAt'] != null
          ? map['updatedAt'] as Timestamp
          : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      keywords: map['keywords'] != null
          ? List<String>.from(map['keywords'] as List<dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber: map['phoneNumber'] != null
          ? map['phoneNumber'] as String
          : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "keywords": [
        ...keywordsBuilder(name ?? ''),
        ...keywordsBuilder(phoneNumber ?? ''),
      ],
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": updatedAt,
      "fcmToken": fcmToken,
    };
  }

  Map<String, dynamic> updateProfileToMap() {
    return {
      'name': name,
      "phoneNumber": phoneNumber,
      'keywords': [
        ...keywordsBuilder(name ?? ''),
        ...keywordsBuilder(phoneNumber ?? ''),
      ],
    };
  }

  Map<String, dynamic> editUserToMap() {
    return {
      "id": id,
      'name': name,
      'keywords': [
        ...keywordsBuilder(name ?? ''),
        ...keywordsBuilder(phoneNumber ?? ''),
      ],
      "updatedAt": updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    List<String>? keywords,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      keywords: keywords ?? this.keywords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
