import 'package:flutter/material.dart';
import 'home_page.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController usernameTextEditingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

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
                    builder: (context) => HomePage(),
                  ));
            },
            icon: Icon(Icons.home),
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
                        print(_dateController.text);
                        print(_amountController.text);
                        print(debitAccountValue);
                        print(creditAccountValue);
                        print(_descriptionController.text);
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
