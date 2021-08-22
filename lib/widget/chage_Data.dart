
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
class Profile extends StatefulWidget {
  @override
  Change_Data createState() => Change_Data();
}
class Change_Data extends State<Profile> {
//  Change_Data({Key key,@required this.document}) : super(key: key);
//  DocumentSnapshot document;
  File _image ;
  String _uploadedFileURL;
  SharedPreferences pref;
  getID() async {
    pref = await SharedPreferences.getInstance();

  }
    @override
    Widget build(BuildContext context) {
      getID();

      return Scaffold(
        appBar: AppBar(),
        body:Container(
          color: Colors.white,
          child: SingleChildScrollView(

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ProductProvider>(builder: (context, pp, child) =>GestureDetector(
                    child:CircleAvatar(
                      radius: 150,
                      backgroundImage:Provider.of<ProductProvider>
                        (context,listen: false).URLImage.toString()!=null ? NetworkImage(Provider.of<ProductProvider>
                        (context,listen: false).URLImage)
                          :AssetImage('images/person-icon.jpg') ,
                    ),
                    onTap: ()async{
                     chooseFile(context);
                     // uploadFile(context);
                      print(Provider.of<ProductProvider>(context,listen: false).URLImage.toString()+
                          Provider.of<ProductProvider>(context,listen: false).uid.toString());
                      Firestore.instance.collection('user').document(Provider.of<ProductProvider>(context,listen: false).uid)
                          .updateData({
                        'user_image': Provider.of<ProductProvider>(context,listen: false).URLImage,
                      });
                     print(Provider.of<ProductProvider>(context,listen: false).uid);
                    },
                  ),
                  ),

                  _rowEdit(context, Provider.of<ProductProvider>(context,listen: false).name),
                  _rowEdit(context, Provider.of<ProductProvider>
                    (context,listen: false).email),
                ]
            ),
          ) ,
        ) ,
      )  ;
    }
    Widget _rowEdit(BuildContext context,String text){
    return Container(
      //color: Colors.white,
      margin: EdgeInsets.all(15),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,style: TextStyle(color: Colors.black,fontSize: 15),),
          SizedBox(width:20),
          IconButton(icon: Icon(Icons.edit),color: Colors.purple[300],focusColor: Colors.purple, onPressed: (){}),
        ],
      ),
    );
    }


  Future chooseFile(BuildContext context) async {
    try{
      await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        Provider.of<ProductProvider>(context,listen: false).saveFileImage(image);
        print(Provider.of<ProductProvider>(context,listen: false).fileImage);
        uploadFile(context);
//        setState(() {
//          _image = image;
//        });
      });
    }catch(e){
      print('***********'+e+"*************");
    }

    // print(_image.toString());
  }

  Future uploadFile(BuildContext context) async {

    //print(_image.path.toString()+"nnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    try{
      StorageReference storageReference = FirebaseStorage.instance
          .ref()//.child('profiles/${Path.basename(_image.path)}}');
          .child('profiles/${Path.basename(Provider.of<ProductProvider>(context,listen: false).fileImage.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(Provider.of<ProductProvider>(context,listen: false).fileImage);
      await uploadTask.onComplete;
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {

        Provider.of<ProductProvider>(context,listen: false).saveImage(fileURL);
        print(Provider.of<ProductProvider>(context,listen: false).URLImage);
        setState(() {
          _uploadedFileURL = fileURL;
        });
      });
    }catch(e){
      print('***********'+e.toString()+"*************");
    }

   // print(_uploadedFileURL);
    //return _uploadedFileURL ;
  }


  }


