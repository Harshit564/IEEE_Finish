import 'package:flutter/material.dart';

Widget buttons({Function function, Widget widget}) {
  return RaisedButton(
    onPressed: function,
    child: widget,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ),
    color: Color(0xffCBE7EA),
    elevation: 6.0,
  );
}
