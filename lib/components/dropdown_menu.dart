import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String? valueChoose;
  List<String> listItem = ['one', 'two', 'three']; // Specify List<String>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDown Menu Example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton<String>(
              hint: Text("Select Debit Account "),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 30,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              // Specify DropdownButton<String>
              value: valueChoose,
              onChanged: (newValue) {
                setState(() {
                  valueChoose = newValue!;
                });
              },
              items: listItem.map((valueItem) {
                return DropdownMenuItem<String>(
                  // Specify DropdownMenuItem<String>
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
