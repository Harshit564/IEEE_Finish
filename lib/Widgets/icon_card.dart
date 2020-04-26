import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final Function function;
  final IconData iconData;
  final String text;

  IconCard({
    this.iconData,
    this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  icon: Icon(
                    iconData,
                    size: 30,
                    color: Color(0xffCBE7EA),
                  ),
                  onPressed: function,
                )),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    //color: Color(0xff5cb3bc),
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
