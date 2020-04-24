import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget indHostLabel({@required String hostName}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 10.0,
      right: 10.0,
      bottom: 15.0,
      top: 0.0,
    ),
    child: Text(
      'Event Host : $hostName',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xff5cb3bc),
        fontStyle: FontStyle.italic,
        fontSize: 15.0,
      ),
    ),
  );
}
