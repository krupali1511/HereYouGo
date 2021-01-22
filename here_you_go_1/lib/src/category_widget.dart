import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key key, this.rowNumber, this.callback}) : super(key: key);

  int rowNumber;
  Function callback;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final noteController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "${widget.rowNumber + 1}.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: noteController,
                onChanged: (text) {
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note',
                ),
              ),
            ),
            Icon(Icons.attach_money),
            Expanded(
              child: TextField(
                controller: amountController,
                onChanged: (text) {
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '0.00',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}