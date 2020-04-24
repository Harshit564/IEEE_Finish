import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget indNameLabel({@required String name}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        fontSize: 25.0,
      ),
    ),
  );
}
