import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:bhawan/blocs/controller_bloc.dart';
import 'package:bhawan/pages/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/pages/Login/LoginPage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return authBloc.token == null ? LoginPage() :
  ChangeNotifierProvider.value(value: ControllerBloc(authBloc.token), child: Home(), );
  }
}
