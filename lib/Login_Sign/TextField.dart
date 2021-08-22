
import 'package:flutter/material.dart';
class Text_Field extends StatelessWidget {
  TextEditingController controller ;
  String label;
  Text_Field({Key key,@required this.controller,@required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:16,left:16.0,right: 16),
      child: TextFormField(
        obscureText: label == 'Password'? true : false,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter Your ${label}',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1.5,color: Colors.black),
          ),
          focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 3,color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
  Widget _textField(TextEditingController controller,String label ){
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 16),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter Your ${label}',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1.5,color: Colors.black),
          ),
          focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 3,color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
