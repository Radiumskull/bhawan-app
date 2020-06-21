import 'package:bhawan/models/SwitchModel.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:bhawan/models/SwitchModel.dart';

class SwitchObject extends StatefulWidget {
  final switchObject;
  SwitchObject(this.switchObject);

  @override
  _SwitchObjectState createState() => _SwitchObjectState();
}

class _SwitchObjectState extends State<SwitchObject> {
  @override
  Widget build(BuildContext context) {
    return widget.switchObject.isDimmer ? Container() : Switch(widget.switchObject.switchName, widget.switchObject.value);
  }
}




class Switch extends StatefulWidget {
  final String switchName;
  final bool switchState;
  Switch(this.switchName, this.switchState);

  @override
  _SwitchState createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(this.widget.switchName),
          CustomSwitch(
            activeColor: Colors.orange,
            value: this.widget.switchState,
            onChanged: (value) {
              print("VALUE : $value");

            },
          ),
        ],
      ),
    );;
  }
}
