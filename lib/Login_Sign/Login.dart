import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/authentication/firebaseAuth.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:final_dsc_4/widget/home.dart';
import 'package:final_dsc_4/widget/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TextField.dart';

class Login extends StatelessWidget {
  SharedPreferences pref ;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Login'),
      ),
      body:SingleChildScrollView(


          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
          Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,
          child: Center(child:Text('Login',style: TextStyle(fontSize: 40),) ,),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6bceff), Color(0xff6bceff)],
              ),
              borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(90))),
          ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    Text_Field(controller:emailController,label:'Email' ,),
                    SizedBox(height: 10,),
                    Text_Field(controller:passwordController,label:'Password'),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: FlatButton(
                        color: Colors.indigoAccent[100],
                        onPressed: () async{
                          if (_formKey.currentState.validate()) {
                            //var a = await _firebaseAuth.getCurrentUser();
//                            print(a.metadata);
                            print('hhhhhhhhhhhh');
                            try {
                              var admin = await _firebaseAuth.sigIn(
                                  emailController.text,
                                  passwordController.text);
                              //print(admin.metadata
                              String id = admin.uid;
                              //Provider.of<ProductProvider>(context, listen: false).saveID(id);
                              // saveLoginData(admin.uid,emailController.text,passwordController.text);
                              _saveData(emailController.text, id);
                              print('zxn');
                              _firebaseAuth.getCurrentUser();
                              if (id != null) {
//                              Scaffold.of(context)
//                                  .showSnackBar(SnackBar(
//                                  content: Text('Data is in processing.')));
                                Navigator.push(context,MaterialPageRoute(builder:(context) =>Home(),
                                ),
                                );
                              }
                              emailController.text="";
                              passwordController.text="";
                            }catch(e){
                              print(e);
                            }
                          }
                          emailController.text="";
                          passwordController.text="";
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ) ,

    );
  }

  _saveData(String email, String id)async{
    pref = await SharedPreferences.getInstance();
    pref.setString('email',email);
    pref.setString('id',id);

  }
}