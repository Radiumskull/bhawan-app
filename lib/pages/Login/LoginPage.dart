import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/pages/Login/InputField.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _register = false;

  void changeForm() {

    setState(() {
      _register = !_register;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    final _formKey = GlobalKey<FormState>();
    String _email = "test@gmail.com";
    String _password = "test123";
    String _phone = "1231231231";

    void inputHandler(String inputField, String text) {
      switch (inputField) {
        case "Email":
          _email = text;
          break;
        case "Password":
          _password = text;
          break;
        case "Phone Number":
          _phone = text;
          break;
        default:
          break;
      }
    }

    Widget register = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Register",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 36,
                  fontWeight: FontWeight.w800)),
          SizedBox(
            height: 20,
          ),
          InputField(
              labelText: "Email", inputHandler: inputHandler, type: "email"),
          SizedBox(
            height: 20,
          ),
          InputField(
              labelText: "Phone Number", inputHandler: inputHandler, type: "phone"),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(authBloc.error != null ? authBloc.error : ""),
          ),
        ],
      ),
    );

    Widget login = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Login",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 36,
                  fontWeight: FontWeight.w800)),
          SizedBox(
            height: 20,
          ),
          InputField(
              labelText: "Email", inputHandler: inputHandler, type: "email"),
          SizedBox(
            height: 20,
          ),
          InputField(
              labelText: "Password", inputHandler: inputHandler, type: "password"),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(authBloc.error != null ? authBloc.error : ""),
          ),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
          body: Container(
            color: authBloc.darkMode ? Colors.black : Colors.white,
            child: LoadingOverlay(
              isLoading: authBloc.loading,
              child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight
                        ),
                        child: Container(
                            color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Column(children: <Widget>[
                            Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                              height: 140,
                            ),
                            Text(
                              "Bhawan",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5),
                            ),
                          ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(30),
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(29))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _register ? register : login,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          RaisedButton(
                                            child: Text(_register ? "Login" : "Register", style: TextStyle(fontFamily: 'Montserrat', fontSize: 18),),
                                            onPressed: (){
                                              changeForm();
                                              authBloc.clearError();
                                            },
                                          ),
                                          RaisedButton(
                                            child: Text(_register ? "Register" : "Login", style: TextStyle(fontFamily: 'Montserrat', fontSize: 18),),
                                            onPressed: () async {
                                              final form = _formKey.currentState;
                                              if(form.validate()){
                                                if(_register){
                                                  //Register Process
                                                  await authBloc.register(_email, _phone);
                                                  if(authBloc.error == null){
                                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("A registration link has been sent to your mail."),));
                                                  }
                                                } else {
                                                  //Login Process
                                                  await authBloc.login(_email, _password);
                                                }
                                              }
                                            },
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                  ),
            ),
          )),
    );
  }
}