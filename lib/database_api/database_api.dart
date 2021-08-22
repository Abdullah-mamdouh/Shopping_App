
import 'dart:convert';

import 'package:http/http.dart' as http;

class Data {

  Future fetchAllProduct({ String query}) async {
    try {
      final response = await http.get(Uri.parse(
          "http://fakestoreapi.com/products/"));

      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        //print(list.toString());
        //return list;
        //Iterable list = result["results"];
        // List<Movie> l = new List<Movie>();
        // print(list.toString());
        if(query !=null){
          list =list.where((element) =>
              element['title'].toLowerCase().contains(query.toLowerCase())&&element['title'].toLowerCase().startsWith(query)).toList();
        }
        return jsonDecode(response.body);
        //return  list.map((e) => Product.fromJson(e)).toList();
        //print(products.toString());
        //Provider.of<ProductProvider>(context, listen: false).addProduct(products);
        //return products;
        /// return products;

      }
      else {
        throw Exception("Failed to load movies!");
      }
    } catch (e) {
      print(e);
    }
  }
}