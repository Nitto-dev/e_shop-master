import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/orderCard.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:e_shop/Models/item.dart';

String getOrderId="";
class OrderDetails extends StatelessWidget {
  final String orderID;

  const OrderDetails({Key key, this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getOrderId = orderID;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Order Details",style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future: EcommerceApp.firestore.collection(EcommerceApp.collectionUser).document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                .collection(EcommerceApp.collectionOrders).document(orderID).get(),

            builder: (c , snapshot)
            {
              Map dataMap;
              if(snapshot.hasData)
                {
                  dataMap = snapshot.data.data;
                }
              return snapshot.hasData ? Container(
                child: Column(
                  children: [
                    StatusBanner(status: dataMap[EcommerceApp.isSuccess],),
                    SizedBox(height: 10.0,),
                    // Padding(padding: EdgeInsets.all(4.0),
                    // child: Text("Order ID: "+ getOrderId),
                    // ),
                    Padding(padding: EdgeInsets.all(4.0),
                    child: Text( DateFormat("dd MMMM yyyy hh:mm aa").format(DateTime.fromMicrosecondsSinceEpoch(int.parse(dataMap["orderTime"]))),
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    ),
                    Divider(height: 2.0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: Text("Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: EcommerceApp.firestore.collection("items").where("shortInfo",whereIn: dataMap[EcommerceApp.productID]).getDocuments(),
                      builder: (c, dataSnapshot)
                      {
                        return dataSnapshot.hasData ?
                            OrderDetailsCard(
                              itemCount: dataSnapshot.data.documents.length,
                              data: dataSnapshot.data.documents,
                            ):
                            Center(child: circularProgress(),);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(5.0),
                          child: Text("Subtotal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                        ),
                        Padding(padding: EdgeInsets.all(5.0),
                          child: Text("৳ "+ dataMap[EcommerceApp.totalAmount].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                        ),
                      ],
                    ),
                    Divider(height: 2.0,),
                    FutureBuilder<DocumentSnapshot>(
                      future: EcommerceApp.firestore.collection(EcommerceApp.collectionUser).document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                          .collection(EcommerceApp.subCollectionAddress).document(dataMap[EcommerceApp.addressID]).get(),
                      builder: (c, snap)
                      {
                        return snap.hasData ? ShippingDetails(model: AddressModel.fromJson(snap.data.data),):
                            Center(child: circularProgress(),);
                      },

                    )

                  ],
                ),
              )
                  :Center(child: circularProgress(),);
            },
          ),
        ),
      ),
    );
  }
}



class StatusBanner extends StatelessWidget {
  final bool status;

  const StatusBanner({Key key, this.status}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;
    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Successful" : msg = "Unsuccessful";

    return Container(
      color: Colors.grey,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GestureDetector(
          //   onTap: ()
          //   {
          //     Route route = MaterialPageRoute(builder: (c)=> MyOrders());
          //     Navigator.pushReplacement(context, route);
          //   },
          //   child: Container(
          //     child: Icon(
          //       Icons.arrow_back,color: Colors.white,
          //     ),
          //   ),
          // ),
          SizedBox(width: 20.0,),
          Text("Order Placed " + msg,
          style: TextStyle(color: Colors.white),),
          SizedBox(width: 5.0,),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class ShippingDetails extends StatelessWidget {
  final AddressModel model;

  const ShippingDetails({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0,),
        //Padding(padding: EdgeInsets.symmetric(horizontal: 100,vertical: 5.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Shipment Details",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          ),
        ),
        //),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          width: screenWidth,
          child: Table(
            children: [
              TableRow(
                  children: [
                    KeyText(msg: "Name",),
                    Text(model.name),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "Phone",),
                    Text(model.phoneNumber),
                  ]
              ),TableRow(
                  children: [
                    KeyText(msg: "Flat Number",),
                    Text(model.flatNumber),
                  ]
              ),TableRow(
                  children: [
                    KeyText(msg: "City",),
                    Text(model.city),
                  ]
              ),TableRow(
                  children: [
                    KeyText(msg: "State",),
                    Text(model.state),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "Pin Code",),
                    Text(model.pincode),
                  ]
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Padding(padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: (){
                confirmeduserOrderReceived(context, getOrderId);
              },
              child: Center(
                child: Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Confirmed || Item Received"),
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }

  confirmeduserOrderReceived(BuildContext context, String mOrderId)
  {
    EcommerceApp.firestore.collection(EcommerceApp.collectionUser).document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders).document(mOrderId).delete();
    getOrderId = "";

    Route route = MaterialPageRoute(builder: (c)=> SplashScreen());
    Navigator.pushReplacement(context, route);

    Fluttertoast.showToast(msg: "Order has been Received");
  }
}


int counter = 0;

class OrderDetailsCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  const OrderDetailsCard({Key key, this.itemCount, this.data, this.orderID}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.grey.shade300,
      margin: EdgeInsets.all(10),
      height: itemCount * 180.0,
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
    );
  }
}



Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return  Container(
    padding: EdgeInsets.all(8.0),
    color: Colors.grey.shade300,
    height: 170.0,
    width: width,
    child: Row(
      children: [
        Image.network(model.thumbnailUrl,width: 140.0,height: 140.0,),
        SizedBox(width: 4.0,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0,),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text(
                    model.title, style: TextStyle(color: Colors.black12,fontSize: 14.0),
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
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
            SizedBox(height: 20.0,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Text(r"Total Price: ",style: TextStyle(fontSize: 14.0,
                            color: Colors.black,

                          ),
                          ),
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
            //Flexible(child: Container(),),
          ],
        ))
      ],
    ),
  );
}
