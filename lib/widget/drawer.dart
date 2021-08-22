
import 'dart:io';

import 'package:final_dsc_4/Login_Sign/Login.dart';
import 'package:final_dsc_4/authentication/firebaseAuth.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:final_dsc_4/widget/view_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drower extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}
class _DrawerState extends State<Drower> {

  FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();

  String name ='';
  String email  ;
  String im ;
  File _image;
  String _uploadedFileURL;
  String id;
  SharedPreferences pref;
  String type;

//  List<Menu> _list = [
//    Menu('Add_Product', () => Add_Product()),
//    Menu('Add_Category', () => Add_Category()),
//    Menu('Add_Tap', () => Add_Tap()),
//    Menu('Add_Admin', () => Add_Admin()),
//  ];
//  Future<void>getID() async {
//    pref = await SharedPreferences.getInstance();
//    setState((){
//      id = pref.getString('id').toString();
//      email = pref.getString('email').toString();
//    });
    // print(id);
  //}
  @override
  initState(){
    // TODO: implement initState
    super.initState();
    //getID();

  }
  @override
  Widget build(BuildContext context) {
    //getID();
   // return
  }

}
