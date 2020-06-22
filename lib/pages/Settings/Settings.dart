import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget{
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Container(
      color: authBloc.darkMode ? Colors.black87 : Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: SwitchListTile(
                title: Text('DarkMode', style: TextStyle(color: authBloc.darkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold),),
                value: authBloc.darkMode,
                onChanged: (bool value) => authBloc.changeUI(value),
                secondary: Icon(Icons.lightbulb_outline, color: authBloc.darkMode ? Colors.white : Colors.black,),
              )
            ),
          ],
        ),
    );
  }
}