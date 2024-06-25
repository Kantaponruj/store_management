import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String uuid;
  late String accountNumber;
  late String accountName;

  ProductModel({
    this.uuid = "",
    required this.accountNumber,
    required this.accountName,
  });

  ProductModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    uuid = documentSnapshot.id;
    accountNumber = documentSnapshot["accountNumber"];
    accountName = documentSnapshot["accountName"];
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;

    return data;
  }
}
