import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ieeepecstudentdeadline/Widgets/ind_listTile.dart';
import 'package:ieeepecstudentdeadline/constants.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/ind_workshop_page.dart';

class PESWorkshopsPage extends StatefulWidget {
  static const String routeName = "/pes-workshops-page";

  @override
  _PESWorkshopsPageState createState() => _PESWorkshopsPageState();
}

class _PESWorkshopsPageState extends State<PESWorkshopsPage> {
  final _fireStore = Firestore.instance;

  Widget nothing(){
    return Center(
      child: Container(
        child: Center(
          child: Text(
            'No workshops available',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: _fireStore
                  .collection(fireStoreWorkshopCollectionLabel)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final workshops = snapshot.data.documents;
                  List<IndListTile> workshopListTiles = [];
                  for (var workshop in workshops) {
                    if(workshop.data[firestoreHostNameLabel] != "PES"){
                      continue;
                    }
                    final workshopName = workshop.data[firestoreNameLabel];
                    final workshopDate = workshop.data[firestoreDateLabel];

                    final workshopListTile = IndListTile(
                      date: workshopDate,
                      name: workshopName,
                      onTapFunction: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndWorkshopPage(
                            documentSnapshot: workshop,
                          ),
                        ),
                      ),
                    );

                    workshopListTiles.add(workshopListTile);
                  }
                  return Column(
                    children: workshopListTiles,
                  );
                }
                return nothing();
              },
            ),
          ],
        ),
      ),
    );
  }
}
