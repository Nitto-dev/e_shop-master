//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            //title: Text("E Shop"),
            //centerTitle: true,
            bottom: TabBar(

              tabs: [
                Tab(
                  icon: Icon(Icons.lock),
                  text: "login",

                ),
                Tab(
                  icon: Icon(Icons.perm_contact_cal_rounded),
                  text: "Register",
                )
              ],
              indicatorColor: Theme.of(context).accentColor,
              indicatorWeight: 5.0,
            ),
          ),
          body: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [Colors.blue,
            //     Colors.blueAccent],
            //         begin: Alignment.topRight,
            //         end: Alignment.bottomLeft
            //   )
            // ),
            child: TabBarView(
              children: [
                Login(),
                Register()
              ],
            ),
          ),
        ),
      )
    );
  }
}
