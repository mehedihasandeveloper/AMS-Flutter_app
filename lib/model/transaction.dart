import 'dart:convert';

class Transaction {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? userName;
  String? entryDate;
  String? debitAccount;
  String? creditAccount;
  String? amount;
  String? description;

  // List<Transaction> usersFromJson(String string) => List<Transaction>.from(
  //     jsonDecode(string).map((x) => Transaction.fromJson(x)));

  // Static method to parse JSON string into a list of Transaction objects
  static List<Transaction> usersFromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Transaction.fromJson(item)).toList();
  }

  Transaction(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.userName,
      this.entryDate,
      this.debitAccount,
      this.creditAccount,
      this.amount,
      this.description});

  // Method to create a Transaction object from a JSON map
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'].toString(), // Convert to String if ID is expected as int
      createdAt: json['createdAt'] ?? '', // Handle null case with default value
      updatedAt: json['updatedAt'] ?? '',
      createdBy: json['createdBy'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
      userName: json['userName'] ?? '',
      entryDate: json['entryDate'] ?? '',
      debitAccount: json['debitAccount'] ?? '',
      creditAccount: json['creditAccount'] ?? '',
      amount: json['amount']
          .toString(), // Convert to String if amount is expected as int
      description: json['description'] ?? '',
    );
  }

  // Transaction.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   createdAt = json['createdAt'];
  //   updatedAt = json['updatedAt'];
  //   createdBy = json['createdBy'];
  //   updatedBy = json['updatedBy'];
  //   userName = json['userName'];
  //   entryDate = json['entryDate'];
  //   debitAccount = json['debitAccount'];
  //   creditAccount = json['creditAccount'];
  //   amount = json['amount'];
  //   description = json['description'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['userName'] = this.userName;
    data['entryDate'] = this.entryDate;
    data['debitAccount'] = this.debitAccount;
    data['creditAccount'] = this.creditAccount;
    data['amount'] = this.amount;
    data['description'] = this.description;
    return data;
  }
}



  // Transaction? transaction;

  // Transaction({this.transaction});

  // Transaction.fromJson(Map<String, dynamic> json) {
  //   transaction = json['item'] != null ? new Transaction.fromJson(json['item']) : null;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.transaction != null) {
  //     data['item'] = this.transaction!.toJson();
  //   }
  //   return data;
  // }
