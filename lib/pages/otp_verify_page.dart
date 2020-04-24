import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieeepecstudentdeadline/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyPage extends StatefulWidget {
  static const String routeName = "/otp-verify-page";

  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {

  final _OtpVerifyFormKey = GlobalKey<FormState>();

  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  String studentContact = "";
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _contactInputController = TextEditingController();
  final _firestore = Firestore.instance;

  FirebaseUser currentUser;
  SharedPreferences prefs;

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
        if(_OtpVerifyFormKey.currentState.validate()){
          setState(() {
            phoneNo = _contactInputController.text.toString().trim();
          });
          _firestore
          .collection('contacts')
          .document(phoneNo)
          .setData({
            'Phone No.': phoneNo,
          });
        }
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exception) {
            print('${exception.message}');
          });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(
              'Enter SMS Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontFamily: 'Montserrat', color: Color(0xff546E7A)),
                ),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/login-page');
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user = await _auth.signInWithCredential(credential);
      FirebaseUser currentUser = await _auth.currentUser();
      // assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      FirebaseUser firebaseUser = user.user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verification',
          style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Card(
              color: Color(0xffCBE7EA),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Enter the Number for Verification \n'
                  'in format +910000000000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter Phone Number'),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
            ),
            (errorMessage != ''
                ? Text(
                    'Please enter a valid number',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  )
                : Container()),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                verifyPhone();
              },
              child: Text(
                'Verify',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 16),
              ),
              color: Color(0xffCBE7EA),
            )
          ],
        ),
      ),
    );
  }
}
