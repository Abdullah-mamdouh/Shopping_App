
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

  WidgetsFlutterBinding w = await WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref.getString('id'));
  bool seen = pref.getBool('seen');
  Widget _screen = Register();
  if(seen==null||seen==false){
    _screen= Register();
  }
  else{
    _screen =View_Product();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),child: MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(

    primarySwatch: Colors.blue,
    ),
    home:Splash(),
    //MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
