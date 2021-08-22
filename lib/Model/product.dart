
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String title;
   double price ;
  final String description;
  final String category;
  final String image;

  Product({this.title,this.price ,this.description, this.category, this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        image: json["image"]
    );
  }

  // get data from API
  Future fetchAllProduct() async {
    try{
      final response = await http.get(Uri.parse(
          "http://fakestoreapi.com/products/" ));

      if (response.statusCode == 200) {
        final list = jsonDecode(response.body);
        //print(list.toString());
        //return list;
        //Iterable list = result["results"];
        // List<Movie> l = new List<Movie>();
        // print(list.toString());
        return jsonDecode(response.body);
        //return  list.map((e) => Product.fromJson(e)).toList();
        //print(products.toString());
        //Provider.of<ProductProvider>(context, listen: false).addProduct(products);
        //return products;
        /// return products;

      } else {
        throw Exception("Failed to load movies!");
      }
    }catch(e){
      print(e);
    }

  }
}
enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}