import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:bhawan/blocs/controller_stream.dart';
import 'package:bhawan/models/SwitchModel.dart';
import 'package:bhawan/pages/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/pages/Login/Login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return authBloc.token == null ? Login() :
    StreamProvider<List<SwitchModel>>.value(value: ControllerStream(authBloc.token).switches, child: Home(), catchError: (context, error) => null,);
  }
}