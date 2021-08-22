
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/authentication/firebaseAuth.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:final_dsc_4/widget/home.dart';
import 'package:final_dsc_4/widget/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'TextField.dart';

class Register extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();
  final _formKey = GlobalKey<FormState>();
  bool valuefirst = false;
  SharedPreferences pref;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = _firebaseAuth.getID();
    //Stream<DocumentSnapshot> document  = Firestore.instance.collection('user').document(id).snapshots() ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true ,
        title: Text('Registeration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(

                  children: <Widget>[
                    Text_Field(controller:nameController,label:'Name' ,),
                    Text_Field(controller:emailController,label:'Email' ,),
                    Text_Field(controller:passwordController,label:'Password' ,),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FlatButton(
                        color: Colors.indigoAccent[100],
                        onPressed: () async{
                          if (_formKey.currentState.validate()) {

                            var user = await _firebaseAuth.register(emailController.text, passwordController.text);
//                            Provider.of<ProductProvider>(context, listen: false).saveID(user.uid);
//                            Provider.of<ProductProvider>(context, listen: false).saveName_Pasword(nameController.text,emailController.text);
                            _saveData(nameController.text, emailController.text, user.uid);
                            _updateSeen();
                            await Firestore.instance.collection('user').document(user.uid).
                            setData({
                              'user_name': nameController.text,
                              'user_email':  emailController.text,
                            });

                            nameController.text ='';
                            emailController.text="";
                            passwordController.text="";

                           // print(user.metadata);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => Home()));
                          }
                        },
                        child: Text('Register'),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('If You Have Account? Click here  ',style: TextStyle(fontSize: 15,backgroundColor: Colors.yellow),),
                        SizedBox(width: 10,),
                        GestureDetector(
                          child:Text('LogIn ',style: TextStyle(fontSize: 20,color: Colors.white,backgroundColor: Colors.teal),),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login(),

                            ),);
                          }
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ) ,

    );
  }

  void _updateSeen()async {
    pref = await SharedPreferences.getInstance();
    pref.setBool('seen', true);
  }

  _saveData(String name ,String email, String id)async{
    pref = await SharedPreferences.getInstance();
    pref.setString('name',name);
    pref.setString('email',email);
    pref.setString('id',id);

  }

}
