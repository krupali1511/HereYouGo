import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/models/ExpenseModel.dart';
import 'package:here_you_go_1/src/expenses.dart';

class TripExpene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trips"),
      ),
      body: TExpense(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

        },
        label: Text('Add',
            style: TextStyle(color:Colors.white)),
        icon: Icon(Icons.add, color:Colors.white),
        backgroundColor: Colors.black87,
      ),
    );
  }
}

class TExpense extends StatefulWidget {
  @override
  _TExpenseState createState() => _TExpenseState();
}

class _TExpenseState extends State<TExpense> {
  getExpenses() {
    return Firestore.instance.collection("expense").snapshots();
  }
  deleteExpense(ExpenseModel expenseModel) {
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(expenseModel.reference);
      },
    );
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Expense()));
          },

        ),


      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: buildBody(context),
          ),
        ],
      ),
    );
  }
}

