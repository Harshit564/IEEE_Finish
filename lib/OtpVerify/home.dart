import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:ieeepecstudentdeadline/Widgets/theme.dart';
import 'package:ieeepecstudentdeadline/pages/login_page.dart';

enum SingingCharacter { light, dark, fault }

class HomePageOtp extends StatefulWidget {
  final FirebaseUser user;

  HomePageOtp({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  _HomePageOtpState createState() => _HomePageOtpState();
}

class _HomePageOtpState extends State<HomePageOtp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

/*
  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(
        backgroundColor: Color(0xffCBE7EA),
        titleStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
        descStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
      ),
      context: context,
      type: AlertType.warning,
      title: "SIGN OUT",
      desc: "Do you want to sign out your phone number ?",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(
                fontFamily: 'Montserrat', color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color(0xFF20BF55),
            Color(0xFF01BAEF),
          ]),
        ),
        DialogButton(
          child: Text(
            "Sign Out",
            style: TextStyle(
                fontFamily: 'Montserrat', color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            _firebaseAuth.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => App()));
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
*/
  SingingCharacter _character = SingingCharacter.dark;

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        /*      actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _onAlertButtonsPressed(context),
            tooltip: "Setting",
          ),
    ],*/
      ),
      body: Container(
        color: Color(0xffCBE7EA),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/p5.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(
                  elevation: 10,
                  //color: Color(0xffCBE7EA),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Change Theme",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Montserrat'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.wb_sunny),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RaisedButton(
                                      elevation: 20,
                                      color: Color(0xff5cb3bc),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Light",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        _themeChanger.setTheme(ThemeData(
                                            primaryColor: Color(0xffCBE7EA)));
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 110,
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Feather.moon),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RaisedButton(
                                      elevation: 20,
                                      color: Color(0xff5cb3bc),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Dark",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        _themeChanger
                                            .setTheme(ThemeData.dark());
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(
                  elevation: 10,
                  //color: Color(0xffCBE7EA),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Change Theme",
                          style: TextStyle(
                              //  color: Color(0xff5cb3bc),
                              fontSize: 20.0,
                              fontFamily: 'Montserrat'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          title: Text(
                            "Dark",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              //color: Color(0xff5cb3bc)
                            ),
                          ),
                          leading: Icon(
                            Feather.moon,
                            //    color: Colors.black
                          ),
                          trailing: Radio(
                            value: SingingCharacter.dark,
                            groupValue: _character,
                            activeColor: Color(0xff5cb3bc),
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                _themeChanger.setTheme(ThemeData.dark());
                              });
                            },
                          ),
                        ),
                        Divider(
                          thickness: 3.0,
                        ),
                        ListTile(
                          title: Text(
                            "Light",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              //color: Color(0xff5cb3bc)
                            ),
                          ),
                          leading: Icon(
                            Feather.sun,
                            //    color: Colors.black
                          ),
                          trailing: Radio(
                            //hoverColor: Color(0xffCBE7EA),
                            value: SingingCharacter.light,
                            groupValue: _character,
                            activeColor: Color(0xff5cb3bc),
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                _themeChanger.setTheme(
                                    ThemeData(primaryColor: Color(0xffCBE7EA)));
                              });
                            },
                          ),
                        ),
                        Divider(
                          thickness: 3.0,
                        ),
                        ListTile(
                          title: Text(
                            "Custom",
                            style: TextStyle(
                                //    color: Color(0xff5cb3bc),
                                fontFamily: 'Montserrat'),
                          ),
                          leading: Icon(
                            Feather.activity,
                            //color: Colors.black
                          ),
                          trailing: Radio(
                            value: SingingCharacter.fault,
                            groupValue: _character,
                            activeColor: Color(0xff5cb3bc),
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                _themeChanger.setTheme(
                                    ThemeData(primaryColor: Color(0xff5cb3bc)));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                color: Color(0xff5cb3bc),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Enter Details",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 16.0),
                ),
                onPressed: () {
                  _firebaseAuth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
