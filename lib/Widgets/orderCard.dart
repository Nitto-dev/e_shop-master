import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';

int counter = 0;

class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  const OrderCard({Key key, this.itemCount, this.data, this.orderID}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
        Route route;
        route = MaterialPageRoute(builder: (c)=> OrderDetails(orderID: orderID));
        Navigator.push(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(color: Colors.grey.shade300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(orderID,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              ),
              Container(
                color: Colors.grey.shade300,
                margin: EdgeInsets.all(10),
                height: itemCount * 40.0,
                child: ListView.builder(
                    itemCount: itemCount,
                    physics: NeverScrollableScrollPhysics(

                    ),
                    itemBuilder: (c, index)
                    {
                      ItemModel model = ItemModel.fromJson(data[index].data);
                      return sourceOrderInfo(model, context);
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return  Container(
    padding: EdgeInsets.only(top: 8.0),
    color: Colors.grey.shade300,
    //height: 170.0,
    width: width,
    child: Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text(
                    model.title, style: TextStyle(color: Colors.black45,fontSize: 16.0,fontWeight: FontWeight.bold),
                  ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 2.0,),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text(
                    model.shortInfo, style: TextStyle(color: Colors.black54,fontSize: 12.0),
                  ),
                  ),
                ],
              ),
            ),
          ],
        )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 3.0),
              child: Row(
                children: [
                  // Text(r"Total Price: ",style: TextStyle(fontSize: 14.0,
                  //   color: Colors.black,
                  //
                  // ),
                  // ),
                  Text(r"৳ ",style: TextStyle(fontSize: 16.0, color: Colors.red,),),
                  Text((model.price).toString(),style: TextStyle(fontSize: 15.0,
                    color: Colors.black,
                  ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
