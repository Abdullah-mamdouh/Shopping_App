
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Show_Product extends StatelessWidget {
  Show_Product({Key key,@required this.document}) : super(key: key);
  var document;

  //FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Flexible(child: Text(document['title'],style: TextStyle(backgroundColor: Colors.purple,fontSize: 18,color: Colors.white),)),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(

        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: 15,left: 15,bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration:document['image']!=null? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: Colors.black,

                      ),
                      image: DecorationImage(
                        image: NetworkImage(document['image']),
                        fit: BoxFit.cover,
                      )
                  ):BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      )
                  ),
                ),
              ),
              //SizedBox(height: 11,),
              Row(
                children:[
                  //Text('Price',style:TextStyle(fontSize: 20,backgroundColor: Colors.purple,color: Colors.white)),
                  _container('Price', context,TextStyle(fontSize: 20,color: Colors.white),Colors.purple),
                  _container(document['price'].toString()+" EGP",context,
                      TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.green),Colors.white),
                ]
              ),

             // SizedBox(height: 11,),
              Row(
                children:[
                  //Text('Category',style:TextStyle(fontSize: 20,backgroundColor: Colors.purple,color: Colors.white)),
                  _container('Category', context, TextStyle(fontSize: 20,color: Colors.white),Colors.purple),
                  _container(document['category'],context,TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.black),Colors.white),
                  ]
              ),
              SizedBox(height: 11,),
                  _container(document['description'],context,TextStyle(fontSize: 15,color: Colors.white),Colors.purple),
              SizedBox(height: 11,),
              Center(
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  child: Text('Add to Card',style: TextStyle(fontSize: 20),),
                  onPressed: ()async{
                    List shoppingList = [
                      {'product_name':document['title'],
                        'product_price':document['price'],
                        'product_description':document['description'],
                        'product_image':document['image'],
                        'product_category':document['category']}
                    ];
                    await Firestore.instance
                        .collection('user')
                        .document(Provider.of<ProductProvider>(context, listen: false).uid)
                        .updateData({'shopping Product':FieldValue.arrayUnion(shoppingList)
                    });
                  },
                  //style: TextStyle(color: Colors.lightGreen[700],),

                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
  Widget _container(String text,BuildContext context,TextStyle textStyle,Color _color){
    return Container(
      //color: Colors.purple,
       // width:MediaQuery.of(context).size.width*0.7 ,
      margin: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.02 ,left: 10,right: 10,bottom: 5 ),
        padding: EdgeInsets.all(8),
        decoration:BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.8,
            color: Colors.black,

          ),
        ),
        child: Text(' ${text}',style: textStyle),
      );
  }
}
