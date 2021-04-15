import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/customButton.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';




class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AdminSignInScreen(),
      ),
    );
  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  final TextEditingController _adminIDTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double _screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return SingleChildScrollView(
      child: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [Colors.lightBlue,
        //           Colors.indigo],
        //         begin: Alignment.topRight,
        //         end: Alignment.bottomLeft
        //     )
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Image.asset("images/admin.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0),
              child: Text("Admin",style: TextStyle(color: Colors.white,fontSize: 28.0,fontWeight: FontWeight.bold),),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _adminIDTextEditingController,
                    data: Icons.email,
                    hintText: "ID",
                    isObsecure: false,
                  ), CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0,),
            CustomButton(buttonText: "Login",onPressed: (){_adminIDTextEditingController.text!= "" &&
                _passwordTextEditingController.text!= ""
                ? loginAdmin()
                : showDialog(context: context,
                builder: (c)
                {
                  return ErrorAlertDialog(message: "Please write Email and Password",);
                }
            );},),
            SizedBox(height: 50.0,),
            SizedBox(height: 20.0,),
            FlatButton.icon(onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthenticScreen())),
                icon: (Icon(Icons.nature_people,color: Colors.white,)),
                label: Text("I am Not Admin",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
            SizedBox(height: 110.0,),
          ],
        ),
      ),
    );
  }

  loginAdmin()
  {
    Firestore.instance.collection("admins").getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if(result.data["id"]!=_adminIDTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Your id is not correct"),));
        }
        else if(result.data["password"]!=_passwordTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Your password is not correct"),));
        }
        else
          {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Dear Admin, "+ result.data["name"]),));

            setState(() {
              _adminIDTextEditingController.text = "";
              _passwordTextEditingController.text = "";

              Route route = MaterialPageRoute(builder: (c)=> UploadPage());
              Navigator.pushReplacement(context, route);
            });
          }
      });
    });
  }
}
