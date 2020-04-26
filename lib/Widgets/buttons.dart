import 'package:flutter/material.dart';

Widget buttons({Function function, Widget widget}) {
  return RaisedButton(
    onPressed: function,
    child: widget,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ),
    color: Color(0xff5cb3bc),
    elevation: 6.0,
  );
}
