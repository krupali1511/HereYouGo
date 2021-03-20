import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:here_you_go_1/Screens/TripDetails.dart';
import 'package:here_you_go_1/models/tripModel.dart';
import 'package:here_you_go_1/services/TripApi.dart';


class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context)),
      floatingActionButton: buildAddDetails(),
    );
  }


  buildAddDetails() {
    return FloatingActionButton(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        _navigateToAddDetails();
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireBaseAPI.TripStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        if (snapshot.data.documents.length > 0) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  child:  TextField(
                    decoration: InputDecoration(
                      labelText: "Trip Name",
                      fillColor: Colors.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RaisedButton(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),

                    ),
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Add'),
                    ),
                    onPressed: () {

                    },
                  ),
                ),
                _buildTripList(context, snapshot.data.documents),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              "There is no trips yet",
              style: Theme.of(context).textTheme.title,
            ),
          );
        }
      },
    );
  }

  Widget _buildTripList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children:
      snapshot.map((data) => _buildTripItem(context, data)).toList(),
    );
  }

  Widget _buildTripItem(BuildContext context, DocumentSnapshot data) {
    final trips = trip.fromSnapshot(data);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Slidable.builder(
       // delegate: SlidableStrechDelegate(),
        secondaryActionDelegate: new SlideActionBuilderDelegate(
            actionCount: 2,
            builder: (context, index, animation, renderingMode) {
              if (index == 0) {
                return new IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TripDetails(
                        docId: data.documentID,
                        name: trips.name,
                      ),
                      fullscreenDialog: true,
                    ),
                  ),
                  closeOnTap: false,
                );
              } else {
                return new IconSlideAction(
                  caption: 'Delete',
                  closeOnTap: false,
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () =>
                      _buildConfirmationDialog(context, data.documentID),
                );
              }
            }),
        key: Key(trips.source),
        child: ListTile(
          title: Text(trips.source),
          onTap: () => print(trips),
        ),
      ),
    );
  }

  Future<bool> _buildConfirmationDialog(
      BuildContext context, String documentID) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure you want to delete'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  FireBaseAPI.removeTrip(documentID);
                  Navigator.of(context).pop(true);
                }),
          ],
        );
      },
    );
  }

  void _navigateToAddDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TripDetails(),
        fullscreenDialog: true,
      ),
    );
  }

}




