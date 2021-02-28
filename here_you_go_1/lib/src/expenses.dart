import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_currency_converter/Currency.dart';
import 'package:here_you_go_1/models/ExpenseModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_currency_converter/flutter_currency_converter.dart';
class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Expense(),
    );
  }
}

class Expense extends StatefulWidget {
  const Expense({Key key}) : super(key: key);

  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  String title = "Expense";
  String test = "";
  static String dropdownValuefrom;
  static String dropdownValueto;
  static double curencyAmount = 0.00;
  final noteController = TextEditingController();
  final amountController = TextEditingController();
  String collection = "expense";
  static double expenseTotal = 0.00;
  static int num = 0;
  static String currencyTo = "INR";
  static String currencyFrom = "INR";

  currencyCheck() async {
    try {
      print("currencycheck");
      curencyAmount = await FlutterCurrencyConverter.convert(
          Currency(currencyFrom, amount: expenseTotal), Currency(currencyTo)
      );
      setState(() {
        try{
          test = curencyAmount.toString();
        }
        catch(e){
          print(e.toString());
        }
      });
    } catch (e) {
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
        num +=1;

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
              .collection('expensetotal')
              .where('uid', isEqualTo: 1);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  updateExpense(ExpenseModel expenseModel, String note, double amount) {
    try {
      setState(() {
        expenseTotal -= expenseModel.amount;
        expenseTotal += amount;
      });
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
      num -=1;
    });
    Firestore.instance.runTransaction(
      (Transaction transaction) async {
        await transaction.delete(expenseModel.reference);
      },
    );
  }

  initExpenses() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("expense").getDocuments();
    var list = querySnapshot.documents;
    for (int i = 0; i < list.length; i++) {
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
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(expense.amount.toString()),
          subtitle: Text(expense.note),
          trailing: IconButton(
            icon: Icon(Icons.delete,color: Colors.black,),
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

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(

          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Container(
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Total Expense",
                        style: TextStyle(color: Colors.white),),
                        Text(expenseTotal.toString(), style: TextStyle(color: Colors.white),),
                        RichText(
                          text: TextSpan(
                            text: num.toString(),
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "Total Expenses",
                          style: TextStyle(fontSize: 20.0,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.black87,
                ),
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
        label: Text('Add',
          style: TextStyle(color:Colors.white)),
        icon: Icon(Icons.add, color:Colors.white),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
