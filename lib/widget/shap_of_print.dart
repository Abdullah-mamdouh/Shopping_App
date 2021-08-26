
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buy_product.dart';
class Shape {

  Widget showImage(BuildContext context,String URL) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .height * 0.2,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.2,
      //child:Image.network(document['image_URL'],fit: BoxFit.cover,),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(URL,),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          )
      ),
    );
  }
  Widget printText(String text,{bool fontBold,double fontSize,Color color}){
    return Text(
        text.toString(), style: TextStyle(
        fontWeight: fontBold != true ? FontWeight.bold:FontWeight.normal,
        fontSize: fontSize,
        color: color,
    )
    );
  }
}
