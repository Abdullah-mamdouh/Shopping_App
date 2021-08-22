
import 'dart:io';

import 'package:final_dsc_4/Model/product.dart';
import 'package:flutter/material.dart';



class ProductProvider with ChangeNotifier {
//String name = '';
bool isFavorite = false;
Product _p = new Product();
List<Product> products = [] ;
int selectedIndex =0;
String uid= '' , name = '' , email = '' ,URLImage ;
File fileImage ;
bool theme = false;
//ProductProvider(){
//  products = getProduct();
//  notifyListeners();
//
//}
void selectedItem(int val){
  selectedIndex = val;
  notifyListeners();
}
changeTheme(bool val){
  theme = val;
  notifyListeners();
}
saveID(String id){
  uid = id;
  print(uid.toString()+'44444');
  notifyListeners();
}

saveName_email(String Name,String Email){
  name = Name;
  email = Email;
  print(name.toString()+'44444');
  notifyListeners();
}
saveImage(String urlImage){
  URLImage = urlImage;
  print(URLImage.toString()+'44444');
  notifyListeners();
}

saveListProduct(Product product){
products.add(product);
notifyListeners();
}

favorite(bool value){
  isFavorite =value;
  //print(isFavorite.toString());
  notifyListeners();
}

saveFileImage(File file){
  fileImage = file;
  notifyListeners();
}


}