import 'package:final_project/pages/add_transaction_page.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/model/transaction.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class ViewTransactions extends StatefulWidget {
  const ViewTransactions({super.key});

  @override
  State<ViewTransactions> createState() => _ViewTransactionsState();
}

class _ViewTransactionsState extends State<ViewTransactions> {
  late List<Transaction> _userModel = [];

  final String restApi = 'https://checking-tlhc.onrender.com/j';

  Future<void> _deleteTransaction(String? id) async {
    try {
      var deleteUrl = 'https://checking-tlhc.onrender.com/j/$id';
      var response = await http.delete(Uri.parse(deleteUrl));

      if (response.statusCode == 200) {
        // Transaction deleted successfully, update UI accordingly
        _getData(); // Refresh data after deletion
      } else {
        throw Exception('Failed to delete transaction');
      }
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }

  Future<void> _getData() async {
    try {
      var response = await http.get(Uri.parse(restApi), headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        setState(() {
          _userModel = Transaction.usersFromJson(
              response.body); // Use Transaction.usersFromJson
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.home),
            ),
          ],
          title: const Center(
            child: Text(
              'All Transactions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: const {
                // Set fixed widths for columns to prevent overflow
                0: FixedColumnWidth(85.0), // Date
                1: FixedColumnWidth(100.0), // Amount
                2: FixedColumnWidth(130.0), // Debit
                3: FixedColumnWidth(130.0), // Credit
                4: FixedColumnWidth(100.0), // Actions
              },
              children: [
                // Table headers
                const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: Text("Date"),
                    )),
                    TableCell(child: Center(child: Text("Amount"))),
                    TableCell(child: Center(child: Text("Debit"))),
                    TableCell(child: Center(child: Text("Credit"))),
                    TableCell(child: Center(child: Text("Actions"))),
                  ],
                ),
                // Populate table rows with transaction data
                for (var transaction in _userModel)
                  TableRow(
                    children: [
                      TableCell(
                          child:
                              Center(child: Text(transaction.entryDate ?? ''))),
                      TableCell(
                          child: Center(child: Text(transaction.amount ?? ''))),
                      TableCell(
                          child: Center(
                              child: Text(transaction.debitAccount ?? ''))),
                      TableCell(
                          child: Center(
                              child: Text(transaction.creditAccount ?? ''))),
                      TableCell(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.update),
                                onPressed: () {



                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTransaction(ngmodel: transaction,)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteTransaction(transaction.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
