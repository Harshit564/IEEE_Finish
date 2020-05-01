import 'package:flutter/material.dart';
import 'package:ieeepecstudentdeadline/constants.dart';

Widget buttons({Function function, Widget widget}) {
  return RaisedButton(
    onPressed: function,
    child: widget,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ),
    color: CustomTheme,
    elevation: 6.0,
  );
}
