import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:bhawan/blocs/controller_stream.dart';
import 'package:bhawan/models/SwitchModel.dart';
import 'package:bhawan/pages/Home/SwitchObject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authBloc = Provider.of<AuthBloc>(context);
    final switches = Provider.of<List<SwitchModel>>(context);
    print(switches.length);
    print(switches[3].value);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            width: 85,
            child: FlatButton(
              color: Colors.yellow,
              onPressed: authBloc.logout,
              child: Text("Log Out"),
              padding: EdgeInsets.only(left: 10, right: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(29),
                  bottomLeft: Radius.circular(29),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: switches.length,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text(switches[index].switchName),
            subtitle: Text(switches[index].value.toString()),
          );
      })
      );
  }
}
