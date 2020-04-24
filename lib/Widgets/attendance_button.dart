import 'package:flutter/material.dart';

Widget attendanceButton({@required Function function}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        onPressed: function,
        color: Color(0xffCBE7EA),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Attendance',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
                color: Color(0xff5cb3bc)),
          ),
        ),
      ),
    ),
  );
}
