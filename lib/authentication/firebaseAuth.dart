

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String id;

  void setID(String id) {
    this.id = id;
  }

  String getID() {
    return id;
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser users = await _firebaseAuth.currentUser();
    //print("kk"+users.toString());
    String users_id = users.uid;
    setID(users_id);
    print(users.uid.toString() + "   vv   " + getID().toString());
    return users;
  }

  Future<FirebaseUser> sigIn(String email, String password) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(authResult);
      return authResult.user;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> register(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password) as AuthResult;
    return authResult.user;
  }
}