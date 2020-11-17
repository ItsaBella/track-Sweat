import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  bool checkbox = false;
  String displayName , Email , Number,password, password2;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text('USER REGISTRATION',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30
                    ,  color: Colors.black),
              ),
              SizedBox(height: size.height * 0.02),
              RoundedInputField(
                hintText: "Name(s)",
                onChanged: (value) {
                  displayName = value;
                },
              ),
              RoundedInputField(
                hintText: "E-mail",
                onChanged: (value) {
                  Email = value;
                },
              ),
              RoundedInputField(
                hintText: "Number",
                onChanged: (value) {
                  Number = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedConfirmPasswordField(
                onChanged: (value) {
                  password2 = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Container(margin:
              EdgeInsets.symmetric(vertical: 10, horizontal:size.width * 0.05),
                child:ListTile(leading: CircularCheckBox(inactiveColor: kPrimaryColor,activeColor: kPrimaryColor,value: checkbox, onChanged: (bool value){
                  setState(() {
                    checkbox = value;
                  });
                },),title: Text('Hey there my name is ITu'),),),

              RoundedButton(text: 'Sign Up',press: (){
                validateForm();
              },),
              SizedBox(height: size.height * 0.03,),
          Center(child: Text('Already have an account?'),),
          RoundedButton(text: 'Sign In',press: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
        },),
            ]),
        ),
      ]),
    );
  }

  validateForm(){
    if(displayName.isEmpty || displayName.length ==0 || displayName == null){
    ShowToast('Please fill in name.');
    }else if(Email.isEmpty || Email.length==0 || Email == null){
      ShowToast('Please fill in email.');
    }else if(password != password2 || password.isEmpty || password2.isEmpty ){
      ShowToast('Please fill in password and ensure that passwords match');
    }else if(password.length < 8){

    }else{
      registerToFirebase();
    }
  }

  registerToFirebase(){
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: password).then((value) => (){
      ShowToast('Registration Succesful, Returning to login page');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    }).catchError((){
      ShowToast('Email already exists, please login');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    });
  }
  
ShowToast(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

}
