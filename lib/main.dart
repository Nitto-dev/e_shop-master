import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Counters/ItemQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'Store/storehome.dart';


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static Color darkBluishColor = Color(0xff403b58);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (c)=>CartItemCounter()),
      ChangeNotifierProvider(create: (c)=>ItemQuantity()),
      ChangeNotifierProvider(create: (c)=>AddressChanger()),
      ChangeNotifierProvider(create: (c)=>TotalAmount()),
    ],
    child: MaterialApp(
        //title: 'e-Shop',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
          canvasColor: Colors.white,
          accentColor: darkBluishColor,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              //textTheme: Theme.of(context).textTheme,
            )
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.black,
            brightness: Brightness.dark,
          canvasColor: Colors.black,
          accentColor: Colors.white,
            appBarTheme: AppBarTheme(
              color: Colors.black,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              //textTheme: Theme.of(context).textTheme
            )
        ),
        home: SplashScreen()
    ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  displaySplash(){
    Timer(Duration(seconds: 2),() async{
      if(await EcommerceApp.auth.currentUser()!= null)
        {
          Route route = MaterialPageRoute(builder: (_) => StoreHome());
          Navigator.pushReplacement(context, route);
        }
      else
        {
          Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
          Navigator.pushReplacement(context, route);
        }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
            "Welcome To Nttto E Commerce",
          style: TextStyle(color: Colors.blue, fontSize: 25.0,fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
