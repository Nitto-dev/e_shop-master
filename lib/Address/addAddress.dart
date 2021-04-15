import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Models/address.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cName = TextEditingController();
  final cPinCode= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: Text("Add New Address"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          if(formkey.currentState.validate())
            {
              final model = AddressModel(
                name: cName.text.trim(),
                state: cState.text.trim(),
                pincode: cPinCode.text.trim(),
                phoneNumber: cPhoneNumber.text.trim(),
                flatNumber: cFlatHomeNumber.text.trim(),
                city: cCity.text.trim(),
              ).toJson();

              EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                  .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .document(DateTime.now().microsecondsSinceEpoch.toString())
                  .setData(model)
                  .then((value)
              {final snack = SnackBar(content: Text("New Address Added Successfully"));
              scaffoldkey.currentState.showSnackBar(snack);
              FocusScope.of(context).requestFocus(FocusNode());
              formkey.currentState.reset();
              });
              Route route = MaterialPageRoute(builder: (c)=> StoreHome());
              Navigator.pushReplacement(context,route);
            }

        }, label: Text("Done"),backgroundColor: Colors.pink,icon: Icon(Icons.check),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text(
              //       "Add New Address",
              //       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
              //     ),
              //   ),
              // ),
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      MyTextField(
                        hint: "Name",
                        controller: cName,
                      ),MyTextField(
                        hint: "Phone Number",
                        controller: cPhoneNumber,
                      ),MyTextField(
                        hint: "Flat Number / House Number",
                        controller: cFlatHomeNumber,
                      ),MyTextField(
                        hint: "City",
                        controller: cCity,
                      ),MyTextField(
                        hint: "State / Country",
                        controller: cState,
                      ),MyTextField(
                        hint: "Pin Code",
                        controller: cPinCode,
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const MyTextField({Key key, this.hint, this.controller}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val)=> val.isEmpty? "Field Can't be Empty":null,
      ),

    );
  }
}
