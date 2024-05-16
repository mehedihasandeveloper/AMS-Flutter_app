import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class AddTransaction extends StatefulWidget {
  AddTransaction({super.key, this.ngmodel});
  Transaction? ngmodel;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  late TextEditingController _dateController = TextEditingController();
  late TextEditingController _amountController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  late String restApi = 'https://checking-tlhc.onrender.com/j';

  void getData() {
    if (widget.ngmodel != null) {
      //  _dateController = widget.ngmodel!.entryDate as TextEditingController;
      //  _amountController = widget.ngmodel!.amount as TextEditingController;
      _dateController.value =
          TextEditingValue(text: widget.ngmodel!.entryDate.toString());
      _amountController.value =
          TextEditingValue(text: widget.ngmodel!.amount.toString());
      _descriptionController.value =
          TextEditingValue(text: widget.ngmodel!.description.toString());

      print(widget.ngmodel!.debitAccount);
      print(widget.ngmodel!.creditAccount);
    }
    print("Data not get");
  }

  void updateData(String id) async {
    var reqBody = {
      "entryDate": _dateController.text,
      "debitAccount": debitAccountValue,
      "creditAccount": creditAccountValue,
      "amount": _amountController.text,
      "description": _descriptionController.text
    };

    var response = await http.put(Uri.parse(restApi + '/' + id),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
  }

  void addTransactionData() async {
    var reqBody = {
      "entryDate": _dateController.text,
      "debitAccount": debitAccountValue,
      "creditAccount": creditAccountValue,
      "amount": _amountController.text,
      "description": _descriptionController.text
    };

    var response = await http.post(Uri.parse(restApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);
    print(response.statusCode);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    if (widget.ngmodel != null) {
      setState(() {
        debitAccountValue = widget.ngmodel!.debitAccount.toString();
        creditAccountValue = widget.ngmodel!.creditAccount.toString();
      });
    }
  }

  Color rgbColor = const Color.fromARGB(255, 203, 197, 227);

  String? debitAccountValue;
  String? creditAccountValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black12,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            icon: const Icon(Icons.home),
          ),
        ],
        title: const Center(
            child: Text(
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    // Date picker
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: "Date",
                        filled: false,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Amount
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Amount",
                          filled: false,
                          prefixIcon: Icon(Icons.money),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          labelStyle:
                              TextStyle(fontSize: 14.0, fontFamily: "Jersey25"),
                          hintStyle:
                              TextStyle(fontSize: 25, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Dropdown debit
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 62.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // Set background color to white (filled)
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.wallet), // Prefix icon
                          const SizedBox(
                              width: 12), // Spacer between icon and dropdown
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                hint: const Text(
                                  "Select Debit Account",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                value: debitAccountValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    debitAccountValue = newValue!;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'cash',
                                    child: Text('Cash Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'receivableaccount',
                                    child: Text('Receivable Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'EquipmentAccount',
                                    child: Text('Equipment Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'SuppliesAccount',
                                    child: Text('Supplies Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'ExpenseAccount',
                                    child: Text('Expense Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'OwnerDrawings',
                                    child: Text('Owner Drawings'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'PayableAccount',
                                    child: Text('Payable Account'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Dropdown credit
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 62.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // Set background color to white (filled)
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.wallet), // Prefix icon
                          const SizedBox(
                              width: 12), // Spacer between icon and dropdown
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                hint: const Text(
                                  "Select Credit Account",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                value: creditAccountValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    creditAccountValue = newValue!;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'cash',
                                    child: Text('Cash Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'receivableaccount',
                                    child: Text('Receivable Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'EquipmentAccount',
                                    child: Text('Equipment Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'SuppliesAccount',
                                    child: Text('Supplies Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'RevenueAccount',
                                    child: Text('Revenue Account'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'OwnerCapital',
                                    child: Text('Owner Capital'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'PayableAccount',
                                    child: Text('Payable Account'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Amount
                    TextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          labelText: "Description",
                          prefixIcon: Icon(Icons.wrap_text),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          labelStyle:
                              TextStyle(fontSize: 14.0, fontFamily: "Jersey25"),
                          hintStyle:
                              TextStyle(fontSize: 25.0, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.ngmodel != null) {
                          updateData(widget.ngmodel!.id.toString());
                        } else {
                          addTransactionData();
                        }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const ViewTransactions(),
                        //     ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black87),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: const BorderSide(
                                          color: Colors.white)))),
                      child: const SizedBox(
                        height: 45.0,
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Jersey25",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
