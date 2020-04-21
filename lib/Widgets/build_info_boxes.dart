import 'package:flutter/material.dart';

Widget buildInfoBoxes({Icon icon, String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 50.0,
      vertical: 4.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xffCBE7EA),
        border: Border.all(
          color: Color(0xffCBE7EA),
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
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    ),
  );
}
