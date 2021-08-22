

class User {
  String name;
  String email;
  String image;

  User({this.name, this.email,this.image});

  User.fromJson(Map<String, dynamic> parsedJSON):
        name = parsedJSON['name'],
        email = parsedJSON['email'];
       // image = parsedJSON['image'];
}