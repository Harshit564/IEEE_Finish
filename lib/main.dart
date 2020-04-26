import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:ieeepecstudentdeadline/OnBoardingPages/onboarding_screen.dart';
import 'package:ieeepecstudentdeadline/pages/about_page.dart';
import 'package:ieeepecstudentdeadline/pages/app_coordinators/app_coordinators_page.dart';
import 'package:ieeepecstudentdeadline/pages/news/news_page.dart';
import 'package:ieeepecstudentdeadline/pages/sessions/sessions_page.dart';
import 'package:ieeepecstudentdeadline/pages/sponsors_page.dart';
import 'package:ieeepecstudentdeadline/pages/team_members/members_page.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/cs_workshops.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/main_tab_screen.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/pes_workshops.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/wie_workshops.dart';

import 'Widgets/theme.dart';
import 'pages/events_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/splash_screen_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData(primaryColor: Color(0xffCBE7EA))),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: theme.getTheme(),
      home: SplashScreen(),
      title: 'IEEE PEC',
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
        EventsPage.routeName: (context) => EventsPage(),
        SessionsPage.routeName: (context) => SessionsPage(),
        SponsorsPage.routeName: (context) => SponsorsPage(),
        AboutPage.routeName: (context) => AboutPage(),
        TeamMembersPage.routeName: (context) => TeamMembersPage(),
        NewsPage.routeName: (context) => NewsPage(),
        AppCoordinatorsPage.routeName: (context) => AppCoordinatorsPage(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        CSWorkshopsPage.routeName: (context) => CSWorkshopsPage(),
        PESWorkshopsPage.routeName: (context) => PESWorkshopsPage(),
        WIEWorkshopsPage.routeName: (context) => WIEWorkshopsPage(),
        TabScreen.routeName: (context) => TabScreen(),
      },
    );
  }
}
