import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_currency_converter/Currency.dart';
import 'package:here_you_go_1/models/ExpenseModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_currency_converter/flutter_currency_converter.dart';
import 'package:flutter_currency_converter/flutter_currency_converter.dart';


class Expense extends StatefulWidget {
  const Expense({Key key}) : super(key: key);

  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  String title = "Expense";
  String test = "";
  static String dropdownValue;
  final noteController = TextEditingController();
  final amountController = TextEditingController();
  String collection = "expense";
  static double expenseTotal = 0.00;
  static int num = 0;
    static var currencyTo ;
  static var currencyFrom ;

  currencyCheck() async {
    try{
      print("currencycheck");
      var test2 = await FlutterCurrencyConverter.convert(
          Currency(Currency.INR, amount: 800.0), Currency(Currency.USD));
      setState(() {
        test = test2.toString();
      });
    }
    catch(e){
      print("inside catch of currencycheck");
      print(e.toString());
    }


  }

  getExpenses() {
    return Firestore.instance.collection(collection).snapshots();
  }

  addExpenses() {
    ExpenseModel expense = ExpenseModel(
        note: noteController.text, amount: double.parse(amountController.text));
    try {
      setState(() {
        expenseTotal += double.parse(amountController.text);
      });
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection(collection)
              .document()
              .setData(expense.toJson());
        },
      );
      // add total to expensetotal table
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection('expensetotal').where('uid', isEqualTo: 1);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  updateExpense(ExpenseModel expenseModel, String note, double amount) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction
            .update(expenseModel.reference, {'note': note, 'amount': amount});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  deleteExpense(ExpenseModel expenseModel) {
    setState(() {
      expenseTotal -= expenseModel.amount;
    });
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(expenseModel.reference);
      },
    );
  }

  initExpenses() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("expense").getDocuments();
    var list = querySnapshot.documents;
    for (int i=0;i<list.length;i++){
      expenseTotal += list[i]['amount'];

    }
    num = list.length;
    print(expenseTotal.toString());
  }


  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getExpenses(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          //print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final expense = ExpenseModel.fromSnapshot(data);
    return Padding(
      key: ValueKey(data.reference.documentID),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(expense.amount.toString()),
          subtitle: Text(expense.note),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // delete
              deleteExpense(expense);
            },
          ),
          onTap: () {
            Alert(
                context: context,
                title: "Update",
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.book),
                        labelText: expense.note,
                      ),
                    ),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.money),
                        labelText: expense.amount.toString(),
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      updateExpense(expense, noteController.text,
                          double.parse(amountController.text));
                      // noteController.clear();
                      //amountController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("init");
    initExpenses();
    currencyCheck();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
          SizedBox(
          height: 100,
          child: Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          RichText(
          text: TextSpan(
          text: expenseTotal.toString(),
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),

      ),
      Text(
        "Total",
        style: TextStyle(fontSize: 22.0),
      ),
      Text(test),
      DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.deepPurple
        ),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['INR', 'USD', 'CAD', 'AUD','AUE']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            onTap: (){
              currencyTo = value;
            },
          );
        })
            .toList(),
      ),
      ],

    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    RichText(
    text: TextSpan(
    text: num.toString(),
    style: TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: Colors.black),
    ),
    ),
    Text(
    "Total Expenses",
    style: TextStyle(fontSize: 20.0),
    ),
    ],
    ),
    ],
    ),
    ),
    Flexible(
    child: buildBody(context),
    ),
    ],
    ),
    ),
    appBar: AppBar(
    title: Text(title),
    ),
    floatingActionButton: FloatingActionButton.extended(
    onPressed: () {
    Alert(
    context: context,
    title: "Add",
    content: Column(
    children: <Widget>[
    TextField(
    controller: noteController,
    decoration: InputDecoration(
    icon: Icon(Icons.book),
    labelText: 'Note',
    ),
    ),
    TextField(
    controller: amountController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    icon: Icon(Icons.money),
    labelText: 'Amount',
    ),
    ),
    ],
    ),
    buttons: [
    DialogButton(
    onPressed: () {
    addExpenses();
    noteController.clear();
    amountController.clear();
    Navigator.pop(context);
    },
    child: Text(
    "Add",
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    )
    ]).show();
    },
    label: Text('Add'),
    icon: Icon(Icons.add),
    backgroundColor: Colors.blue,
    ),
    );
    }
}
