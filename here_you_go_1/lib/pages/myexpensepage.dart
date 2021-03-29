import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:here_you_go_1/models/ExpenseModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math' as math;

class Expense extends StatefulWidget with NavigationStates {
  final String tripName;

  const Expense({Key key, this.tripName}) : super(key: key);

  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> with TickerProviderStateMixin {
  String title = "Expense";
  String test = "";
  final noteController = TextEditingController();
  final amountController = TextEditingController();
  String collection = "expense";
  static double expenseTotal = 0.00;
  static int num = 0;
  bool isExpenseLoaded = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  getExpenses() {
    return Firestore.instance
        .collection(collection)
        .where("tripID", isEqualTo: widget.tripName)
        .snapshots();
  }

  addExpenses() {
    ExpenseModel expense = ExpenseModel(
        note: noteController.text,
        amount: double.parse(amountController.text),
        tripID: widget.tripName);
    try {
      setState(() {
        expenseTotal += double.parse(amountController.text);
        num += 1;
      });
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          await Firestore.instance
              .collection(collection)
              .document()
              .setData(expense.toJson());
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
      num -= 1;
    });
    Firestore.instance.runTransaction(
      (Transaction transaction) async {
        await transaction.delete(expenseModel.reference);
      },
    );
  }

  initExpenses() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("expense")
        .where("tripID", isEqualTo: widget.tripName)
        .getDocuments();
    var list = querySnapshot.documents;
    var temp = 0.00;
    for (int i = 0; i < list.length; i++) {
      temp += list[i]['amount'];
    }
    num = list.length;
    setState(() {
      expenseTotal = temp;
      isExpenseLoaded = true;
    });

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
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              // delete
              deleteExpense(expense);
            },
          ),
          onTap: () async {
            await Alert(
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
                      //Navigator.pop(context);
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          if (!isExpenseLoaded) await initExpenses();
          return null;
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              expenseTotal.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 34.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "  Total",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: num.toString(),
                                style: GoogleFonts.lato(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              "  Total Expenses",
                              style: GoogleFonts.lato(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
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
              Flexible(child: buildBody(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Alert(
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
                  onPressed: () async {
                    await addExpenses();
                    noteController.clear();
                    amountController.clear();
                    //Navigator.of(this.context).pop();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        label: Text('Add', style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black87,
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
