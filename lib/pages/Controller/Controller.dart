import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/pages/Controller/SwitchObject.dart';
import 'package:bhawan/blocs/controller_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Controller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerBloc = Provider.of<ControllerBloc>(context);
    final authBloc = Provider.of<AuthBloc>(context);

    final spinkit = SpinKitCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.yellow
          ),
        );
      },
    );

    return controllerBloc.switches.length == 0 ? spinkit : ListView
            .builder(
          itemCount: controllerBloc.switches.length,
          itemBuilder: (context, index) {
            return SwitchObject(controllerBloc.switches[index],
                controllerBloc.updateSwitch, authBloc.darkMode);
          },
    );
  }
}
