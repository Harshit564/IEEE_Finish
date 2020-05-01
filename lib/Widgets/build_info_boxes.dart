import 'package:flutter/material.dart';
import 'package:ieeepecstudentdeadline/constants.dart';

Widget buildInfoBoxes({Icon icon, String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 50.0,
      vertical: 4.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: LightTheme,
        border: Border.all(
          color: LightTheme,
        ),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          leading: icon,
          title: Text(
            value,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    ),
  );
}
