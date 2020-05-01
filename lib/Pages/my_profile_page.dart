import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:ieeepecstudentdeadline/constants.dart';
import 'login_page.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String studentName = "";
  String collegeName = "";
  String studentSID = "";
  String proficiency = "false";
  bool isLoading = false;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences preferences;

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });
  }

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(
        backgroundColor: LightTheme,
        titleStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
        descStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
      ),
      context: context,
      type: AlertType.warning,
      title: "LOG OUT",
      desc: "Do you want to log out your ID ?",
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
            "Log Out",
            style: TextStyle(
                fontFamily: 'Montserrat', color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            handleSignOut().then((val) {
              preferences.clear().then((val) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (e) => false);
                //Navigator.pushNamed(context, LoginPage.routeName);
              });
            });
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  Widget _buildProfileCard(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: LightTheme,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyProfileLogo(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: CircleAvatar(
          radius: 50.0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildProficiencyCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: LightTheme,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: proficiency == 'true'
                ? Text(
                    'Proficiency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                : Text(
                    'Non-Proficiency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _getInfo() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      studentName = preferences.getString("studentName");
      studentSID = preferences.getString("studentSID");
      collegeName = preferences.getString("collegeName");
      proficiency = preferences.getString("proficiency");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'My Profile',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _onAlertButtonsPressed(context),
            tooltip: "Log Out",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: Alignment.center,
          child: ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildMyProfileLogo(myProfilePageLogoPath),
              SizedBox(
                height: 50.0,
              ),
              _buildProfileCard(studentName),
              _buildProfileCard(studentSID),
              _buildProfileCard(collegeName),
              _buildProficiencyCard(),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
