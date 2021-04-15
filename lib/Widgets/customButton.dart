import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const CustomButton({Key key, this.buttonText, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.teal,
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(10.0),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        //color: Colors.amberAccent,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.5,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
