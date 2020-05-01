import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ieeepecstudentdeadline/constants.dart';

class IndMemberListTile extends StatelessWidget {
  final String imageUrl;
  final String memberName;
  final String memberEmailID;
  final String memberContact;
  final String memberPosition;
  final int priority;

  IndMemberListTile({
    @required this.imageUrl,
    @required this.memberName,
    @required this.memberEmailID,
    @required this.memberContact,
    @required this.memberPosition,
    @required this.priority,
  });

  Widget makeListTile(BuildContext context) {
    return Container(
      color: LightTheme,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150.0,
                width: 100.0,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        child: Center(
                          child: Text(
                            'Loading...',
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.person,
                        color: CustomTheme,
                        size: 20.0,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          memberName,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.67,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.assignment_ind,
                            color: CustomTheme,
                            size: 15.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              memberPosition,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.phone,
                            color: CustomTheme,
                            size: 15.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              memberContact,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.alternate_email,
                            color: CustomTheme,
                            size: 15.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              memberEmailID,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: makeListTile(context),
      ),
    );
  }
}
