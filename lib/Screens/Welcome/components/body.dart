import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // This size provide us total height and width of our screen
    return  Scaffold(
      body: Center( child: Container(constraints:
      BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/image1.jpg'),
                  fit: BoxFit.cover ),
          ),
          child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 125.0,
                ),
                Text('WELCOME\n USER!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60
                      , fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: size.height * 0.02),
                Image(image: AssetImage('assets/images/logo.png'),
                  alignment: Alignment.center,
                  height: 580.0,
                  width: 550.0,),

                SizedBox(height: size.height * 0.05),
                RaisedButton(
                  padding: EdgeInsets.only(left:30,right:30),
                  onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                  },
                  elevation: 7,

                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                  ),
                  color: Colors.lightBlue[400],
                  textColor: Colors.white,
                  child: Text(
                    'GET STARTED',
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: '',
                          ),
                  ),),
                SizedBox(height: size.height * 0.05),
                Text('Don\'t have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                GestureDetector(
                  child: Text('REGISTER HERE!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
                  ),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SignUpScreen();
                  }),);
                }, ),

                SizedBox(height: 0.05),

                  ]),
                ),
      ))));
  }


  checkUserLogin(BuildContext context) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      if (await sp.getBool("loggedIn")) {
        //move to another page
      } else {

      }
    }catch(e){

    }

  }}

