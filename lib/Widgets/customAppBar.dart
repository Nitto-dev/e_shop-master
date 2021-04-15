import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      // title: Text(
      //   "E Shop",
      //   style: TextStyle(fontSize: 55.0,color: Colors.white,fontFamily: "Signatra"),
      // ),
      bottom: bottom,
      actions: [
        Stack(
          children: [
            IconButton(icon: Icon(Icons.shopping_cart),
                onPressed: ()
                {
                  Route route = MaterialPageRoute(builder: (c)=> CartPage());
                  Navigator.pushReplacement(context, route);
                }),
            Positioned(top: 1.0,bottom: 5.0,
              left: 20.0,
              child: Consumer<CartItemCounter>(
                builder: (context,counter,_)
                {
                  return Text(
                    (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1).toString(),
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
                  );
                },
              ),
            )
          ],
        )
      ],
    );

  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
