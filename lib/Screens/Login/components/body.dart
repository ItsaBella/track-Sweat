import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/StaticValues.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Body extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
   Body({
    Key key,
  }) : super(key: key);
   String email ='', password ='';
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white60,
      body: ListView(children: [ Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.10),
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/logo.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) { email = value;},
              ),
              RoundedPasswordField(
                onChanged: (value) {password = value;},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(text: 'Sign In',press: (){
              },),

              SizedBox(height: size.height * 0.03),
              Center(child: Text('Or')),
              SizedBox(height: size.height * 0.03),
              GestureDetector( child:
              Container(margin: EdgeInsets.only(left: 70, right: 70),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)  ),
                child: Center(
                  child:
                  Image(image: AssetImage('assets/images/gmail.png'),width: 75), ),), onTap: (){
                _handleSignIn(context).then((value)async {
                  if(value.isEmailVerified){
                    setPreferences(value);
                  }
                });

              },)

            ],
          ),
        ),
      ),
      ],));
  }

  Future<FirebaseUser> _handleSignIn(BuildContext context) async{
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final FirebaseUser user = await auth.signInWithCredential(credential);
    return user;
  }

  setPreferences(FirebaseUser user) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("loggedIn", true);
    sp.setString("displayName", user.displayName);
    sp.setString("email", user.email);
    sp.setString("number", user.phoneNumber);
    /////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    StaticClass.name = user.displayName;
    StaticClass.emailAddress = user.email;
    StaticClass.phoneNumber = user.phoneNumber;
  }

}
