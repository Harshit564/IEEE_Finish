import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ieeepecstudentdeadline/Widgets/ind_listTile.dart';
import 'package:ieeepecstudentdeadline/constants.dart';
import 'package:ieeepecstudentdeadline/pages/sessions/ind_session_page.dart';

class SessionsPage extends StatefulWidget {
  static const String routeName = "/sessions-page";

  @override
  _SessionsPageState createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final _fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Sessions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder(
              stream: _fireStore
                  .collection(fireStoreSessionsCollectionLabel)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final sessions = snapshot.data.documents;
                  List<IndListTile> sessionListTiles = [];
                  for (var session in sessions) {
                    print(session);
                    final sessionName = session.data[firestoreNameLabel];
                    final sessionDate = session.data[firestoreDateLabel];

                    final eventListTile = IndListTile(
                      name: sessionName,
                      date: sessionDate,
                      onTapFunction: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndSessionPage(
                            documentSnapshot: session,
                          ),
                        ),
                      ),
                    );

                    sessionListTiles.add(eventListTile);
                  }
                  return Column(
                    children: sessionListTiles,
                  );
                }
                return Center(
                  child: Container(
                    child: Center(
                      child: Text(
                        'No sessions available',
                      ),
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
