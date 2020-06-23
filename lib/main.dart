import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:bhawan/pages/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value : AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bhawan',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(
            minWidth: 120,
            height: 48,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(29))
            ),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
