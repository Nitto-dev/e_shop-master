import 'dart:ui';

import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).canvasColor, //This will change the drawer background to blue
      ),
      child: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 25,bottom: 10),
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    elevation: 8.0,
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                  style: TextStyle(color: Colors.white,fontSize: 35.0,fontFamily: "signatra"),
                  )
                ],
              ),
            ),
            //SizedBox(height: 12.0,),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c)=> StoreHome());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  //Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  ListTile(
                    leading: Icon(Icons.assignment_turned_in_rounded),
                    title: Text("My Orders",),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c)=> MyOrders());
                      Navigator.push(context, route);
                    },
                  ),
                  //Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text("My Cart"),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c)=> CartPage());
                      Navigator.push(context, route);
                    },
                  ),
                  //Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text("Search"),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c)=> SearchProduct());
                      Navigator.push(context, route);
                    },
                  ),
                  //Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text("Add New Address"),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c)=> AddAddress());
                      Navigator.push(context, route);
                    },
                  ),
                  //Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                    onTap: (){
                      EcommerceApp.auth.signOut().then((c) {
                        Route route = MaterialPageRoute(builder: (c)=> AuthenticScreen());
                        Navigator.pushReplacement(context, route);
                      });
                    },
                  ),
                  //Divider(height: 10,color: Colors.white,thickness: 6.0,),

                ],
              ),
            )
          ],

        ),
      ),
    );
  }
}
