import 'package:bhawan/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bhawan/blocs/controller_bloc.dart';
import 'package:provider/provider.dart';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  double sliderValue;

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
            return controller.switches[index].isDimmer ?
            Dimmer(controller.switches[index],
                controller.updateSwitch, authBloc.darkMode) : Switch(controller.switches[index],
                controller.updateSwitch, authBloc.darkMode);
          },
        );
      } ,
    );
  }
}


class Dimmer extends StatefulWidget {
  final switchObject;
  final Function updateSwitch;
  final bool darkMode;
  Dimmer(this.switchObject, this.updateSwitch, this.darkMode);
  @override
  _DimmerState createState() => _DimmerState();
}

class _DimmerState extends State<Dimmer> {
  double sliderValue = 0.0;
  @override
  void initState() {
    sliderValue = widget.switchObject.value.toDouble();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 120,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(29)),
            color: widget.darkMode ? Color.fromRGBO(255, 255, 255, 0.95) : Color.fromRGBO(0, 0, 0, 0.05)
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("DIMMER " + widget.switchObject.switchName.substring(1), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            RepaintBoundary(
              child: Slider(
                onChanged: (value){
                  setState(() {
                    sliderValue = value;
                  });
                },
                onChangeEnd: (value){
                  widget.updateSwitch({ widget.switchObject.switchName : value.toInt() });
                },
                activeColor: Colors.orange,
                label: (sliderValue/255 * 100).round().toString() + "%",
                value: sliderValue,
                min: 0.0,
                max: 255.0,
                divisions: 100,
              ),
            ),
          ],
        )
    );
  }
}

class Switch extends StatelessWidget {
  final switchObject;
  final Function updateSwitch;
  final bool darkMode;
  Switch(this.switchObject, this.updateSwitch, this.darkMode);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 120,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          color: switchObject.value ? Colors.green : Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("SWITCH " + switchObject.switchName.substring(1) , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            Container(width : 120, height: 52, child: RaisedButton(
              onPressed: () => this.updateSwitch({switchObject.switchName : !switchObject.value}), child: Text(switchObject.value ? 'Turn Off' : 'Turn On' ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.circular(switchObject.value ? 29 : 0),
                bottomRight: Radius.circular(switchObject.value ? 29 : 0),

                topRight: Radius.circular(switchObject.value ? 0 : 29 ),
                bottomLeft: Radius.circular(switchObject.value ? 0 : 29 ),
              ),),
            )
            ),
          ],
        )
    );
  }
}
