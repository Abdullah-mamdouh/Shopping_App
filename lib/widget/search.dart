import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dsc_4/database_api/database_api.dart';
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buy_product.dart';

class SearchUser extends SearchDelegate {
  List<bool> isfavourite = List.filled(20, false);
  final _textController = TextEditingController();
  //SharedPreferences pref ;
  //String uid;


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            print(_textController.text);
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return FutureBuilder(
      future: Data().fetchAllProduct(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List data = snapShot.data;
          return ListView.builder(
            itemCount: snapShot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
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
                                image:  NetworkImage(data[index]['image'],),
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
                                    data[index]['title'], style: TextStyle(
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
                                    Text(data[index]['price'].toString(),
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
                                          {'product_name':data[index]['title'],
                                            'product_price':data[index]['price'],
                                            'product_description':data[index]['description'],
                                            'product_image':data[index]['image'],
                                            'product_category':data[index]['category']}
                                        ];
                                        await Firestore.instance
                                            .collection('user')
                                            .document(Provider.of<ProductProvider>(context,listen: false).uid)
                                            .updateData({'shopping Product':FieldValue.arrayUnion(shoppingList)
                                        });
                                        print('ooooooooooooooo');
                                      },
                                      child: Text('Buy',style: TextStyle(fontSize: 15,color: Colors.pink),),
                                      //style: TextButton.styleFrom(backgroundColor: Colors.white30),
                                    ),
                                    Consumer<ProductProvider>(builder: (context, pp, child) => IconButton(
                                        icon:Icon(isfavourite[index]? Icons.favorite: Icons.favorite_border,color: Colors.red,),
                                        onPressed: () async{
//                                                Product p = new Product(title: data[index]['title'],image:data[index]['image'],
//                                                    category:data[index]['category'],price: data[index]['price'],
//                                                    description:data[index]['description']);
                                          Provider.of<ProductProvider>(context, listen: false).favorite(!isfavourite[index]);
                                          isfavourite[index]=pp.isFavorite;
                                          List favouriteList = [
                                            {'product_name':data[index]['title'],
                                              'product_price':data[index]['price'],
                                              'product_description':data[index]['description'],
                                              'product_image':data[index]['image'],
                                              'product_category':data[index]['category']}
                                          ];
                                          //Provider.of<ProductProvider>(context, listen: false).saveListProduct(p);
                                          // print(Provider.of<ProductProvider>(context, listen: false).products);
                                          await Firestore.instance
                                              .collection('user')
                                              .document(Provider.of<ProductProvider>(context,listen: false).uid)
                                              .updateData({'favourite Product':FieldValue.arrayUnion(favouriteList)
                                          });

                                          print(Provider.of<ProductProvider>(context, listen: false).isFavorite.toString());
                                        }
                                    ),
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
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Products'),
    );
  }
}
