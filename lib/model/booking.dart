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
    required this.createdAt, required this.updatedAt
  });

  //Firebaseからデータを取得する際の変換処理
  Booking.fromJson(Map<String, Object?> json)
      : this(
    id: json['id'] as String,
    title: json['title']! as String,
    owner: json['owner']! as String,
    leaveDateTime: json['leaveDateTime'] as DateTime,
    price: json['price'] as int,
    address: json['address'] as String,
    requireNumber: json['requireNumber'] as int,
    capacity: json['capacity'] as int,
    target: json['target'] as String,
    memberList: json['memberList'] as List<String>,
    picture: json['picture'] as String,
    ownerId: json['ownerId'] as String,
    createdAt: json['createdAt'] as DateTime,
    updatedAt: json['updatedAt'] as DateTime,
  );

  //DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}