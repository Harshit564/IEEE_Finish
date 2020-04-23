import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ieeepecstudentdeadline/Widgets/member_listTile.dart';
import '../../constants.dart';

class TeamMembersPage extends StatefulWidget {
  static const String routeName = "/team-members-page";

  @override
  _TeamMembersPageState createState() => _TeamMembersPageState();
}

class _TeamMembersPageState extends State<TeamMembersPage> {
  final _fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Members',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22.0),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: _fireStore
                  .collection(fireStoreTeamMembersCollectionLabel)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final members = snapshot.data.documents;
                  List<IndMemberListTile> memberListTiles = [];
                  for (var member in members) {
                    final memberName =
                        member.data[firestoreTeamMemberNameLabel];
                    final memberContact =
                        member.data[firestoreTeamMemberContactLabel];
                    final memberEmailID =
                        member.data[firestoreTeamMemberEmailIDLabel];
                    final memberPosition =
                        member.data[firestoreTeamMemberPositionLabel];
                    final memberImageUrl = member.data[firestoreImageUrl];
                    final priority = member.data['priority'];

                    final memberListTile = IndMemberListTile(
                      imageUrl: memberImageUrl,
                      memberName: memberName,
                      memberContact: memberContact,
                      memberEmailID: memberEmailID,
                      memberPosition: memberPosition,
                      priority: priority,
                    );

                    memberListTiles.add(memberListTile);
                    memberListTiles.sort((m1, m2){
                      return m1.priority.compareTo(m2.priority);
                    });
                  }

                  return Column(
                    children: memberListTiles,
                  );
                }
                return Center(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Unexpected Error Occurred',
                        style: TextStyle(fontFamily: 'Montserrat'),
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
