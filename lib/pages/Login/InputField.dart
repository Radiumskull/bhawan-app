import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String type;
  final Function inputHandler;
  InputField({this.labelText, this.inputHandler, this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: (text) => this.inputHandler(this.labelText, text.trim()),
        obscureText: this.type == "password" ? true : false,
        style: TextStyle(fontSize: 18),
        validator: (value) {
          if(value.isEmpty) return "Please enter your ${this.labelText.toLowerCase()}.";
          switch(this.type){
            case "email":
              if(!isEmail(value.trim())) return "Please enter a valid email.";
              break;
            case "phone":
              if(!isNumeric(value.trim()) && value.length != 10) return "Enter a Valid Phone Number";
              break;
            default:
              break;
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 5),
          isDense: true,
          labelText: this.labelText,
        ),
      ),
    );
  }
}
