
import 'package:final_dsc_4/widget/drawer.dart';
import 'package:final_dsc_4/widget/home.dart';
import 'package:final_dsc_4/widget/profile.dart';
import 'package:final_dsc_4/widget/splashScreen.dart';
import 'package:final_dsc_4/widget/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login_Sign/Login.dart';
import 'Login_Sign/registration.dart';

Future<void> main() async {

//  WidgetsFlutterBinding w = await WidgetsFlutterBinding.ensureInitialized();
//  SharedPreferences pref = await SharedPreferences.getInstance();
//  print(pref.getString('id'));
//  bool seen = pref.getBool('seen');
//  Widget _screen = Register();
//  if(seen==null||seen==false){
//    _screen= Register();
//  }
//  else{
//    _screen =View_Product();
//  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),child: MaterialApp(
    theme: ThemeData(

    primarySwatch: Colors.blue,
    ),
    home:Splash(),
    //MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    );
  }
}

