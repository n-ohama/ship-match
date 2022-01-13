import 'package:flutter/material.dart';

@immutable
class Booking {
  final String id;
  final String title;
  final String owner;
  final DateTime leaveDateTime;
  final int price;
  final String address;
  final int requireNumber;
  final int capacity;
  final String? target;
  final List<String> memberList;
  final String? picture;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Booking({
    required this.id, required this.title, required this.owner,
    required this.leaveDateTime, required this.price, required this.address,
    required this.requireNumber, required this.capacity, this.target,
    required this.memberList, this.picture, required this.ownerId,
    required this.createdAt, required this.updatedAt,
  });

  //Firebaseからデータを取得する際の変換処理
  Booking.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    title: json['title'],
    owner: json['owner'],
    leaveDateTime: json['leaveDateTime'].toDate(),
    price: json['price'],
    address: json['address'],
    requireNumber: json['requireNumber'],
    capacity: json['capacity'],
    target: json['target'] ?? '',
    memberList: json['memberList'].cast<String>(),
    picture: json['picture'],
    ownerId: json['ownerId'],
    createdAt: json['createdAt'].toDate(),
    updatedAt: json['updatedAt'].toDate(),
  );

  //DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}