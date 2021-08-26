import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_dsc_4/Login_Sign/Login.dart';
import 'package:final_dsc_4/Model/Menu.dart';
import 'package:final_dsc_4/authentication/firebaseAuth.dart';
import 'package:final_dsc_4/database_api/database_api.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:final_dsc_4/widget/search.dart';
import 'package:final_dsc_4/widget/shap_of_print.dart';
import 'package:final_dsc_4/widget/shoppingCart.dart';
import 'package:http/http.dart' as http;
import 'package:final_dsc_4/Model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buy_product.dart';
import 'chage_Data.dart';
import 'drawer.dart';
import 'favorite.dart';

class View_Product extends StatefulWidget {
  @override
  _View_ProductState createState() => _View_ProductState();
}

class _View_ProductState extends State<View_Product> {
  SharedPreferences pref;
  ProductProvider p = new ProductProvider();
  FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();
  List<bool> isfavourite = List.filled(20, false);
  String _imageURL;
  String name, email;
  bool _isDark = false;

  ThemeData _light = ThemeData.light().copyWith(
    primaryColor: Colors.indigo,
  );
  ThemeData _dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
  );

  String uid;
  Future<void> getID() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      uid = pref.getString('id');
    });
    Provider.of<ProductProvider>(context, listen: false).getProducts_FromAPI(Data().fetchAllProduct());
    getData(uid);
    Provider.of<ProductProvider>(context, listen: false)
        .saveID(pref.getString('id').toString());
    print(pref.getString('image'));
  }

  @override
  void initState() {
    super.initState();

    getID();
    getData(uid);
    Data().fetchAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, pp, child) => MaterialApp(
        darkTheme: _dark,
        theme: _light,
        // to make theme dark or light
        themeMode: Provider.of<ProductProvider>(context, listen: false).theme
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            //leading: Icon(Icons.menu),
            title: Text('Page title'),
            actions: [
              //Icon(Icons.favorite),
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchUser());
                },
                icon: Icon(
                  Icons.search_sharp,
                  size: 25,
                ),
              )
              //Icon(Icons.more_vert),
            ],
            backgroundColor: Colors.purple,
          ),
          body: FutureBuilder(
            future: Provider.of<ProductProvider>(context, listen: false).products,
            builder: (context, snapshot) {
              // print(snapshot.data.length);
//Text(snapshot.data[index]['title'])
              if (snapshot.hasData) {
                var data = snapshot.data;

                return new ListView(

                    children: List.generate(data.length, (index) {
                      List product = [
                      {
                        'title': data[index]
                      ['title'],
                      'price': data[index]
                      ['price'],
                      'description':
                      data[index]
                      ['description'],
                      'image': data[index]
                      ['image'],
                      'category': data[index]
                      ['category']
                      }
                      ];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Show_Product(
                            document: data[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: Card(
                        child: Row(
                          children: [
                            Shape().showImage(context, data[index]['image']),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Shape().printText(data[index]['title'],),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Shape().printText("Price :  ",),
                                        Shape().printText(data[index]['price'].toString(),
                                            color: Colors.red,),
                                        Shape().printText(" EGP",
                                            color: Colors.green),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            await Firestore.instance
                                                .collection('user')
                                                .document(pref.getString('id'))
                                                .updateData({
                                              'shopping Product':
                                                  FieldValue.arrayUnion(product)
                                            });
                                            print('ooooooooooooooo');
                                          },
                                          child: Text(
                                            'Buy',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.pink),
                                          ),
                                          //style: TextButton.styleFrom(backgroundColor: Colors.white30),
                                        ),
                                        Consumer<ProductProvider>(
                                          builder: (context, pp, child) =>
                                              IconButton(
                                                  icon: Icon(
                                                    isfavourite[index]
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () async {
                                                    Provider.of<ProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .favorite(!isfavourite[
                                                            index]);
                                                    isfavourite[index] =
                                                        pp.isFavorite;

                                                    await Firestore.instance
                                                        .collection('user')
                                                        .document(pref
                                                            .getString('id'))
                                                        .updateData({
                                                      'favourite Product':
                                                          FieldValue.arrayUnion(
                                                              product)
                                                    });

                                                    print(Provider.of<
                                                                ProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .isFavorite
                                                        .toString());
                                                  }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Consumer<ProductProvider>(
                  builder: (context, pp, child) => UserAccountsDrawerHeader(
                    accountName: Text(
                        Provider.of<ProductProvider>(context, listen: false)
                            .name
                            .toString()),
                    accountEmail: Text(
                        Provider.of<ProductProvider>(context, listen: false)
                            .email
                            .toString()),
                    currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: pp.URLImage == null
                              ? pref.getString('image').toString() != null
                                  ? NetworkImage(
                                      pref.getString('image').toString())
                                  : AssetImage('images/person-icon.jpg')
                              : NetworkImage(pp.URLImage),
                        ),
                        onTap: () {
                          Provider.of<ProductProvider>(context, listen: false)
                              .saveImage(pref.getString('image').toString());
                          Provider.of<ProductProvider>(context, listen: false)
                              .saveName_email(pref.getString('name').toString(),
                                  pref.getString('email').toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(),
                            ),
                          );
                        }),
                  ),
                ),
                ListTile(
                  title: Consumer<ProductProvider>(
                    builder: (context, pp, child) => Switch(
                      onChanged: (val) {
                        Provider.of<ProductProvider>(context, listen: false)
                            .changeTheme(val);
                      },
                      value:
                          Provider.of<ProductProvider>(context, listen: false)
                              .theme,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Colors.redAccent,
                      inactiveTrackColor: Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => View_Product(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Favourite"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favorite(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text("Purchases"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingCart(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("SigOut"),
                  onTap: () async {
                    await _firebaseAuth.signOut();
                    pref.setString('id', '');
                    pref.setString('password', '');
                    pref.setString('email', '');
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("SigIn"),
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }

  getData(String id) async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection("user").getDocuments();
    for (int i = 0; i < snapshot.documents.length; i++) {
      var a = snapshot.documents[i];
      if (a.documentID == uid) {
        // pref.setString('id', a.documentID);
        pref.setString('name', a['user_name']);
        pref.setString('image', a['user_image']);
        pref.setString('email', a['user_email']);

        Provider.of<ProductProvider>(context, listen: false)
            .saveImage(pref.getString('image').toString());
        Provider.of<ProductProvider>(context, listen: false).saveName_email(
            pref.getString('name').toString(),
            pref.getString('email').toString());
        return;
//        Provider.of<ProductProvider>(context, listen: false).saveName_email(a['user_name'], a['user_email']);
//        Provider.of<ProductProvider>(context, listen: false).saveImage(a['user_image']);
//        print(a.documentID+"jjjjjjj"+Provider.of<ProductProvider>(context, listen: false).uid+'hhhh');
      }
      print(a.documentID);
    }
  }
}
