import 'dart:convert';
import 'package:final_project/model/transaction.dart';

class OD {
  int? id;
  String? entryDate;
  double? debitAmount;
  double? creditAmount;
  String? description;
  double? balance;
  Transaction? transaction;

  // Static method to parse JSON string into a list of Transaction objects
  static List<OD> usersFromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => OD.fromJson(item)).toList();
  }

  OD(
      {this.id,
      this.entryDate,
      this.debitAmount,
      this.creditAmount,
      this.description,
      this.balance,
      this.transaction});

  OD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entryDate'];
    debitAmount = json['debitAmount'];
    creditAmount = json['creditAmount'];
    description = json['description'];
    balance = json['balance'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entryDate'] = this.entryDate;
    data['debitAmount'] = this.debitAmount;
    data['creditAmount'] = this.creditAmount;
    data['description'] = this.description;
    data['balance'] = this.balance;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    return data;
  }
}
