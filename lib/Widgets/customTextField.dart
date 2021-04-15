import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;



  CustomTextField(
      {Key key, this.controller, this.data, this.hintText,this.isObsecure}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      decoration: BoxDecoration(
        color:  Colors.grey.shade600,
        borderRadius: BorderRadius.all(Radius.circular(25.0))
      ),
      padding: EdgeInsets.all(1.0),
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller, 
        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            border:InputBorder.none,
          prefixIcon: Icon(
              data,
            color: Colors.grey.shade300,
          ),

        focusColor: Colors.blue,
          hintText: hintText,
        ),
      ),
    );
  }
}
