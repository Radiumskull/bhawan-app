import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/pages/Controller/SwitchObject.dart';
import 'package:bhawan/blocs/controller_bloc.dart';
import 'package:provider/provider.dart';

class Controller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    final spinkit = Center( child : CircularProgressIndicator());

    return Consumer<ControllerBloc>(
      builder: (context, controller, _) {
        return controller.switches.length == 0 ? spinkit : ListView
            .builder(
          itemCount: controller.switches.length,
          itemBuilder: (context, index) {
            return SwitchObject(controller.switches[index],
                controller.updateSwitch, authBloc.darkMode);
          },
        );
      } ,
    );
  }
}
