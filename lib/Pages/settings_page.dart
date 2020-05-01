import 'package:flutter/material.dart';
import 'package:ieeepecstudentdeadline/constants.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:ieeepecstudentdeadline/Widgets/theme.dart';
import 'package:ieeepecstudentdeadline/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

enum SingingCharacter { light, dark, fault }

class HomePageOtp extends StatefulWidget {
  final FirebaseUser user;
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  HomePageOtp(
      {Key key, @required this.user, this.onPressed, this.tooltip, this.icon})
      : assert(user != null),
        super(key: key);

  @override
  _HomePageOtpState createState() => _HomePageOtpState();
}

class _HomePageOtpState extends State<HomePageOtp>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String launchUrl = "";

  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<Color> _buttonColor;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Future<dynamic> _launchUrl(String url) async {
    setState(() {
      launchUrl = url;
    });
    if (await canLaunch(launchUrl)) {
      await launch(launchUrl);
    } else {
      throw 'Could not launch $launchUrl';
    }
  }

  _launchgmail() async {
    const url =
        'mailto:harshitsingh15967@gmail.com?subject=Feedback&body=Feedback for Our Support';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> sharer() async {
    await FlutterShare.share(
        title: 'IEEE Apps share',
        text: 'Download IEEE PEC Android application',
        linkUrl:
            'https://play.google.com/store/apps/developer?id=IEEE+PEC&hl=en',
        chooserTitle: 'IEEE PEC Chooser Title');
  }

  Widget like() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'btn1',
        backgroundColor: CustomTheme,
        onPressed: () => _launchUrl(facebookPageURL),
        tooltip: 'Like',
        child: Icon(
          Feather.facebook,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget share() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'btn2',
        backgroundColor: CustomTheme,
        onPressed: sharer,
        tooltip: 'Share',
        child: Icon(
          Icons.share,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget feedback() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'btn3',
        backgroundColor: CustomTheme,
        onPressed: () => _launchgmail(),
        tooltip: 'Feedback',
        child: Icon(
          Icons.feedback,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'btn4',
        backgroundColor: CustomTheme,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: Colors.black,
          progress: _animateIcon,
        ),
      ),
    );
  }

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  SingingCharacter _character = SingingCharacter.light;

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
        color: LightTheme,
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
              /*            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Material(
                  elevation: 14,
                  borderRadius: BorderRadius.circular(24.0),
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
    */
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Material(
                  elevation: 14,
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.black,
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
                            activeColor: CustomTheme,
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
                            activeColor: CustomTheme,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                _themeChanger.setTheme(
                                    ThemeData(primaryColor: LightTheme));
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
                            activeColor: CustomTheme,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                _themeChanger.setTheme(
                                    ThemeData(primaryColor: CustomTheme));
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
                color: CustomTheme,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3.0,
              0.0,
            ),
            child: like(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: share(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value,
              0.0,
            ),
            child: feedback(),
          ),
          toggle(),
        ],
      ),
    );
  }
}
