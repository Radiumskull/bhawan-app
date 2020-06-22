import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:bhawan/pages/Controller/Controller.dart';
import 'package:bhawan/pages/Settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50,),
              Image.asset('assets/images/logo.png', height: 150,),
              SizedBox(height: 100,),
              Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      authBloc.changePage('Home');
                      Navigator.pop(context);
                    },
                    child: Text('Home'),
                  ),
                  FlatButton(
                    onPressed: () {
                      authBloc.changePage('Settings');
                      Navigator.pop(context);
                    },
                    child: Text('Settings'),
                  ),
                  FlatButton(
                    onPressed: authBloc.logout,
                    child: Text('Log Out'),
                  ),
                ],
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(authBloc.page),
        ),
        body: authBloc.page == 'Home' ? Container(color: authBloc.darkMode ? Colors.black87 : Colors.white , child: Controller()) : Settings(),
    );
  }
}