import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ieeepecstudentdeadline/constants.dart';
import 'package:ieeepecstudentdeadline/pages/about_page.dart';
import 'package:ieeepecstudentdeadline/pages/app_coordinators/app_coordinators_page.dart';
import 'package:ieeepecstudentdeadline/pages/my_profile_page.dart';
import 'package:ieeepecstudentdeadline/pages/sponsors_page.dart';

class HomePageDrawer extends StatefulWidget {
  @override
  _HomePageDrawerState createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  String launchUrl = "";
  SharedPreferences sharedPreferences;
  String studentName = "";
  String emailId = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static bool state = false;

  Future<void> _getInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      studentName = sharedPreferences.getString("studentName") ?? "name";
    });
    final FirebaseUser currentUser = await _auth.currentUser();
    setState(() {
      emailId = currentUser.email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo();
  }

  Widget _buildDrawerListTile(
      {String title, IconData icon, Function function}) {
    return Expanded(
      child: ListTile(
        onTap: function,
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: Icon(icon),
      ),
    );
  }

  Widget _buildURLLogos({String imagePath, String pageURL}) {
    return GestureDetector(
      onTap: () => _launchUrl(pageURL),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 25.0,
        ),
        child: Image.asset(
          imagePath,
          width: 35.0,
          height: 35.0,
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xff5cb3bc),
              child: Icon(
                Icons.person,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              emailId,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            accountName: Text(
              studentName,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          _buildDrawerListTile(
            title: 'My Profile',
            icon: Icons.person_outline,
            function: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyProfilePage())),
          ),
          Divider(),
          _buildDrawerListTile(
            title: 'Sponsors',
            icon: Icons.group,
            function: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SponsorsPage())),
          ),
          Divider(),
          _buildDrawerListTile(
            title: 'App Coordinator',
            icon: Icons.code,
            function: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AppCoordinatorsPage())),
          ),
          Divider(),
          _buildDrawerListTile(
            title: 'About',
            icon: Icons.info_outline,
            function: () => Navigator.pushNamed(context, AboutPage.routeName),
          ),
          SizedBox(
            height: 80.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 22.0,
                    left: 5.0,
                  ),
                  child: Text(
                    drawerFollowLine,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildURLLogos(
                      imagePath: facebookLogoPath,
                      pageURL: facebookPageURL,
                    ),
                    _buildURLLogos(
                      pageURL: instagramPageURL,
                      imagePath: instagramLogoPath,
                    ),
                    _buildURLLogos(
                      imagePath: linkedinLogoPath,
                      pageURL: linkedinPageUrl,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
