import 'package:flutter/material.dart';
import '../model/supplies.dart';
import '../pages/ledger_books_page.dart';
import 'package:http/http.dart' as http;

class SuppliesLedger extends StatefulWidget {
  const SuppliesLedger({super.key});

  @override
  State<SuppliesLedger> createState() => _SuppliesLedgerState();
}

class _SuppliesLedgerState extends State<SuppliesLedger> {
  late List<Supplies> _userModel = [];

  final String restApi = 'https://checking-tlhc.onrender.com/j/supplies';

  Future<void> _getData() async {
    try {
      var response = await http.get(Uri.parse(restApi), headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        setState(() {
          _userModel = Supplies.usersFromJson(
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
              'Supplies Ledger',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Date"),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Dr Amount"),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Cr Amount"),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Balance"),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("TID"),
                      ),
                    ),
                  ],
                ),
                // Populate table rows with transaction data
                for (var transaction in _userModel)
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(transaction.entryDate ?? ''),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text((transaction.debitAmount ?? 0).toString()),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text((transaction.creditAmount ?? 0).toString()),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(transaction.balance.toString()),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(transaction.transaction!.id.toString()),
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
