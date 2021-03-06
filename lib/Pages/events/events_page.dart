import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ieeepecstudentdeadline/Widgets/ind_listTile.dart';
import 'package:ieeepecstudentdeadline/constants.dart';
import 'ind_event_page.dart';

class EventsPage extends StatefulWidget {
  static const String routeName = '/events-page';

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final _fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Events',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: _fireStore
                  .collection(fireStoreEventCollectionLabel)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final events = snapshot.data.documents;
                  List<IndListTile> eventListTiles = [];
                  for (var event in events) {
                    print(event);
                    final eventName = event.data[firestoreNameLabel];
                    final eventDate = event.data[firestoreDateLabel];

                    final eventListTile = IndListTile(
                        date: eventDate,
                        name: eventName,
                        onTapFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IndEventPage(
                                documentSnapshot: event,
                              ),
                            ),
                          );
                        });

                    eventListTiles.add(eventListTile);
                  }
                  return Column(
                    children: eventListTiles,
                  );
                }
                return Center(
                  child: Container(
                    child: Text(
                      'No events available',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
