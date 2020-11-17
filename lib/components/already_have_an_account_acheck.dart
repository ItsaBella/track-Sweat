import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ?
                "REGISTER HERE": "REGISTER HERE",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
            fontSize: 20.0),
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              login ? "Sign In" : "Sign Up",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          )
        ],
      ),
    );
  }
}
