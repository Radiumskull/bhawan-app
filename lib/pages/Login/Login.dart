import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/pages/Login/InputField.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  void inputHandler(String inputField, String text){
    switch(inputField){
      case "Email" :
        _email = text;
        break;
      case "Password" :
        _password = text;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: authBloc.loading ? spinkit : Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(29))
              ),
              child : Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Log In", style : TextStyle(fontFamily: 'Montserrat', fontSize: 36, fontWeight: FontWeight.w800)),
                    InputField(labelText: "Email", inputHandler : this.inputHandler, type : "email"),
                    SizedBox(height: 10,),
                    InputField(labelText: "Password", inputHandler : this.inputHandler, type : "password"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(authBloc.error != null ? authBloc.error : ""),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      child: Text("Log In", style: TextStyle(fontFamily: 'Montserrat', fontSize: 18),),
                      onPressed: () async {
                        final form = _formKey.currentState;
                        if(form.validate()){
                          authBloc.login(_email, _password);
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
