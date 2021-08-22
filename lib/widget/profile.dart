

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/Model/user.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AA extends StatefulWidget {
  @override
  A createState() => A();
}
class A extends State<AA> {
  SharedPreferences pref;
  //List<User> _list  = getUserList();
  String a;
  Future<void>getID() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      a= pref.getString('id');
    });

    //Provider.of<ProductProvider>(context, listen: false).saveID(pref.getString('id').toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getID();
   // a= pref.getString('id').toString();
   // print(a+Provider.of<ProductProvider>(context, listen: false).uid+"jjjjj");

  }
  @override
  Widget build(BuildContext context) {
    //getID();
    //print(a);

    print(Provider.of<ProductProvider>(context, listen: false).uid+"kkkkkkk");
    return StreamBuilder(
        stream: Firestore.instance.collection('user').document(a).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          Provider.of<ProductProvider>(context,listen: false).saveName_email(userDocument['user_name'],userDocument['user_email'])  ;

          print(Provider.of<ProductProvider>(context,listen: false).name);
         return  Text(snapshot.data['user_name']
        );
          //return Text(snapshot.data['user_name']);
//          pref.setString('name', userDocument['user_name']);
//          pref.setString('image', userDocument['user_image']);
//          return ListView(
//              children: snapshot.data.documents.map((DocumentSnapshot document) {
//          return ListTile(
//          title: Text(document['user_name']),
//          subtitle: Text(document['user_email']),
//          );
//          }).toList(),
//          );
        }
    );
  }

  Stream<List<User>> getUserList() {
    return Firestore.instance.collection('user')
        .snapshots()
        .map((snapShot) => snapShot.documents
        .map((document) => User.fromJson(document.data))
        .toList());
  }
  getData(String id) {
    return StreamBuilder(
        stream: Firestore.instance.collection('user').document(id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot == null) {
            return new Text("Loading");
          }
          var userData = snapshot.data;
          print(userData.toString());
          return snapshot.data;
        }
    );
  }
}