import 'dart:async';

import 'package:final_dsc_4/Login_Sign/registration.dart';
import 'package:final_dsc_4/widget/view_product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'Widget/Continent/Continents.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<Splash> {
  Widget _screen ;

 seenScreen()async{
   WidgetsFlutterBinding w = await WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences pref = await SharedPreferences.getInstance();
   print(pref.getString('id'));
   bool seen = pref.getBool('seen');
   _screen = Register();
   if(seen==null||seen==false){
     _screen= Register();
   }
   else{
     _screen =Home();
   }
 }

  @override
  void initState() {
    super.initState();
    seenScreen();

    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => _screen)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.6,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "images/Clothes.png",fit: BoxFit.cover,
            scale: 1.0,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(" Shopping ",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),

              SizedBox(width: 10,),
              Icon(Icons.shopping_cart,color: Colors.white,),
            ],
          ),
        ),


      ]),
    );
  }
}