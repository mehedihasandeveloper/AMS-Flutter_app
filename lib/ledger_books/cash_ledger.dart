import 'package:final_project/model/cash.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../pages/ledger_books_page.dart';

class CashLedger extends StatefulWidget {
  const CashLedger({super.key});

  @override
  State<CashLedger> createState() => _ViewTransactionsState();
}

class _ViewTransactionsState extends State<CashLedger> {
  late List<Cash> _userModel = [];

  final String restApi = 'https://checking-tlhc.onrender.com/j/cash';

  Future<void> _getData() async {
    try {
      var response = await http.get(Uri.parse(restApi), headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        setState(() {
          _userModel = Cash.usersFromJson(
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
                  MaterialPageRoute(
                      builder: (context) => const LedgerBooksPage()),
                );
              },
              icon: const Icon(Icons.home),
            ),
          ],
          title: const Center(
            child: Text(
              'Cash Ledger',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                // Set fixed widths for columns to prevent overflow
                0: FixedColumnWidth(90.0), // Date
                1: FixedColumnWidth(85.0), // Amount
                2: FixedColumnWidth(80.0), // Debit
                3: FixedColumnWidth(100.0), // Credit
                4: FixedColumnWidth(50.0), // Actions
              },
              children: [
                // Table headers
                const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  children: [
                    TableCell(child: Center(child: Text("Date"))),
                    TableCell(child: Center(child: Text("Debit"))),
                    TableCell(child: Center(child: Text("Credit"))),
                    TableCell(child: Center(child: Text("Balance"))),
                    TableCell(child: Center(child: Text("TID"))),
                  ],
                ),

                for (var transaction in _userModel)
                  TableRow(
                    children: [
                      TableCell(
                          child:
                              Center(child: Text(transaction.entryDate ?? ''))),
                      TableCell(
                        child: Center(
                          child:
                              Text((transaction.debitAmount ?? 0).toString()),
                        ),
                      ),
                      TableCell(
                          child: Center(
                              child: Text(
                                  (transaction.creditAmount ?? 0).toString()))),
                      TableCell(
                          child: Center(
                              child: Text(transaction.balance.toString()))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  transaction.transaction!.id.toString()))),
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
