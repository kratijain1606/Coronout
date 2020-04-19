import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';    
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';  

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
  }

    String phoneNo;    
    String smsOTP;    
    String verificationId;    
    String errorMessage = '';    
    FirebaseAuth _auth = FirebaseAuth.instance;    
    
    Future<void> verifyPhone() async {  
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('login', true);
        
        final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {    
            this.verificationId = verId;    
            smsOTPDialog(context).then((value) {    
            print('sign in');    
            });    
        };    
        try {    
            await _auth.verifyPhoneNumber(    
                phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP    
                codeAutoRetrievalTimeout: (String verId) {    
                //Starts the phone number verification process for the given phone number.    
                //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.    
                this.verificationId = verId;    
                },    
                codeSent:    
                    smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.    
                timeout: const Duration(seconds: 20),    
                verificationCompleted: (AuthCredential phoneAuthCredential) {    
                print(phoneAuthCredential);    
                },    
                verificationFailed: (AuthException exceptio) {    
                print('${exceptio.message}');    
                });    
        } catch (e) {    
            handleError(e);    
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
                ),    
                content: Container(    
                    height: 100,    
                    child: Column(children: [    
                    TextField(
                        autofocus: true,
                        cursorColor: Colors.amber,
                        style: TextStyle(height: 2.0),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'Enter OTP here'
                        ),    
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
                    child: Text('Done'),    
                    onPressed: () {    
                        _auth.currentUser().then((user) {    
                        if (user != null) {    
                            Navigator.of(context).pop();    
                            Navigator.of(context).pushReplacementNamed('/homepage');    
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
            final FirebaseUser currentUser = await _auth.currentUser();    
            assert(user.user.uid == currentUser.uid);    
            Navigator.of(context).pop();    
            Navigator.of(context).pushReplacementNamed('/homepage');    
        } catch (e) {    
            handleError(e);    
        }    
    }    
    
    handleError(PlatformException error) {    
        print(error);    
        switch (error.code) {    
            case 'ERROR_INVALID_VERIFICATION_CODE':    
              FocusScope.of(context).requestFocus(new FocusNode());    
              setState(() {    
                  errorMessage = 'Invalid Code';    
              });    
              Navigator.of(context).pop();    
              smsOTPDialog(context).then((value) {    
                  print('sign in');    
              });    
              break;    
            default:    
              setState(() {    
                  errorMessage = error.message;    
              });    
              break;    
        }    
    }    
    
    @override    
    Widget build(BuildContext context) {    
        return Scaffold(    
            appBar: AppBar(
              title: Text(
                'Login',
                style: TextStyle(color: Colors.white),
                
              ),
              backgroundColor: Colors.blueAccent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,    
            body: ListView(    
            children: <Widget>[
              Column(    
                mainAxisAlignment: MainAxisAlignment.center,    
                children: <Widget>[ 
                    Image(image: AssetImage("assets/images/login.png"),),
                    Column(
                      children: <Widget>[
                        ///holds email header and inputField
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 40, bottom: 10),
                              child: Text(
                                "Mobile Number",
                                style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 40, bottom: 30),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 40,
                                    child: Material(
                                      elevation: 10,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(0.0),
                                              topRight: Radius.circular(30.0))),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
                                        child: TextField(    
                                          decoration: InputDecoration(    
                                              hintText: 'Eg. +910000000000'),    
                                          onChanged: (value) {    
                                              this.phoneNo = value;    
                                          },    
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 40),
                                          child: Text(
                                            'Enter your mobile no. to continue...',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(color: Color(0xFFA0A0A0),
                                            fontSize: 12),
                                          ),
                                        )),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: ShapeDecoration(
                                            shape: CircleBorder(),
                                            gradient: LinearGradient(
                                                colors: signInGradients,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_forward_ios),
                                            color: Colors.white,
                                            onPressed: () {    
                                              verifyPhone();    
                                            },
                                            iconSize: 40.0,
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                        (errorMessage != ''    
                            ? Text(    
                                errorMessage,    
                                style: TextStyle(color: Colors.red),    
                                )    
                            : Container()),    
                        SizedBox(    
                            height: 10,    
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50),
                        ),
                      ],
                    )
                  ],
            ),
          ],
        ),
     );
  }
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];
