import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Store/Search.dart';


class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent
      ) =>
      InkWell(
        onTap: (){
          Route route = MaterialPageRoute(builder: (c)=> SearchProduct());
          Navigator.push(context, route);
        },
        child: Container(
          //margin: EdgeInsets.only(left: 4.0, right: 4.0 ),
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              ),
              Padding(padding: EdgeInsets.only(left: 8.0),
              child: Text("Search hear.."),)
            ],
          ),

        ),
      );



  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


