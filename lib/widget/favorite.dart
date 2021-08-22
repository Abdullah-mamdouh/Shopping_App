
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/Model/product.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buy_product.dart';
class Favorite extends StatelessWidget {
  List<bool> isfavourite = List.filled(20, true);
  SharedPreferences pref ;

  getID()async{
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen: false);
    getID();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Favorite Products'),
        centerTitle: true,
      ),
      body: Consumer<ProductProvider>(builder: (context, pp, child) => Container(
        child: Provider.of<ProductProvider>(context,listen: false).uid != null?Consumer<ProductProvider>
          (builder: (context, pp, child) => StreamBuilder(
            stream:Firestore.instance.collection('user').
            document(Provider.of<ProductProvider>(context,listen: false).uid).snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return new Container();
              }
              //print(snapshot.toString());
              var data = snapshot.data['favourite Product'];
              print(data.toString());
              return data != null ?  new ListView(
                  children: List.generate(data.length, (index) =>
                  //data['favourite Product'][index].map((DocumentSnapshot document){
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder:(context) =>
                          Show_Product(document: data[index],),
                      ),
                      );
                    },
                    child: Container(
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.height*0.2,
                              height: MediaQuery.of(context).size.height*0.2,
                              //child:Image.network(document['image_URL'],fit: BoxFit.cover,),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:  NetworkImage(data[index]['product_image'],),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.5,
                                  )
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 10),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                    Text(
                                        data[index]['product_name'].toString(), style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    )
                                    ),
                                    SizedBox(height: 10,),
                                    //Text(document['product_description']),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Price: ",
                                            style:TextStyle(
                                                fontWeight: FontWeight.bold,fontSize: 13
                                            )
                                        ),
                                        Text(data[index]['product_price'].toString(),
                                          style:TextStyle(
                                            fontWeight: FontWeight.bold,color: Colors.red,),
                                        ),

                                        Text(" EGP ",style:TextStyle(
                                          fontWeight: FontWeight.bold,color: Colors.green,
                                        )),
                                      ],
                                    ),
//                            Text(
//                                "Price: " + data[index]['price'].toString()
//                            ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: ()async{
                                            List shoppingList = [
                                              {'product_name':data[index]['product_name'],
                                                'product_price':data[index]['product_price'],
                                                'product_description':data[index]['product_description'],
                                                'product_image':data[index]['product_image'],
                                                'product_category':data[index]['product_category']}
                                            ];
                                            await Firestore.instance
                                                .collection('user')
                                                .document(pref.getString('id'))
                                                .updateData({'shopping Product':FieldValue.arrayUnion(shoppingList)
                                            });
//                                await Firestore.instance
//                                    .collection('user')
//                                    .document(pref.getString('id'))
//                                    .updateData({
//                                  'product':
//                                  {'product_name':data[index]['title'],
//                                    'product_price':data[index]['price'],
//                                    'product_description':data[index]['description'],
//                                    'product_image':data[index]['image'],
//                                    'product_category':data[index]['category'],}
//                                });
                                          },
                                          child: Text('Buy',style: TextStyle(fontSize: 15,color: Colors.pink),),
                                          //style: TextButton.styleFrom(backgroundColor: Colors.white30),
                                        ),
                                        IconButton(
                                            icon:Icon(isfavourite[index]? Icons.favorite: Icons.favorite_border,color: Colors.red,),
                                            onPressed: () async{
//                                              Product p = new Product(title: data[index]['title'],image:data[index]['image'],
//                                                  category:data[index]['category'],price: data[index]['price'],
//                                                  description:data[index]['description']);
                                              List favouriteList = [
                                                {'product_name':data[index]['product_name'],
                                                  'product_price':data[index]['product_price'],
                                                  'product_description':data[index]['product_description'],
                                                  'product_image':data[index]['product_image'],
                                                  'product_category':data[index]['product_category']}
                                              ];
                                              //Provider.of<ProductProvider>(context, listen: false).saveListProduct(p);
                                              print(Provider.of<ProductProvider>(context, listen: false).products);
                                              await Firestore.instance
                                                  .collection('user')
                                                  .document(pref.getString('id'))
                                                  .updateData({'favourite Product':FieldValue.arrayRemove(favouriteList)});
//                                              Provider.of<ProductProvider>(context, listen: false).favorite(!isfavourite[index]);
//                                              isfavourite[index]=pp.isFavorite;
//                                              print(Provider.of<ProductProvider>(context, listen: false).isFavorite.toString());
                                            }
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
//;
//      }
//
//      ),

                  )
              ): Container();
            }
        ),
        ): Container(),
      ),
      ),
    ) ;
  }
}
