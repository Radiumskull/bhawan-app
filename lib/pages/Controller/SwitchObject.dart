import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchObject extends StatelessWidget {
  final switchObject;
  final Function updateSwitch;
  final bool darkMode;
  SwitchObject(this.switchObject, this.updateSwitch, this.darkMode);

  @override
  Widget build(BuildContext context) {
        if(switchObject.isDimmer){
          return Container(
            width: 300,
            height: 120,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(29)),
              color: darkMode ? Color.fromRGBO(255, 255, 255, 0.95) : Color.fromRGBO(0, 0, 0, 0.05)
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("DIMMER " + switchObject.switchName.substring(1), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ),
                Slider(
                  onChanged: (value){},
                  onChangeEnd: (value){
                    this.updateSwitch({ switchObject.switchName : value.toInt() });
                  },
                  activeColor: Colors.orange,
                  label: switchObject.value.toString(),
                  value: switchObject.value.toDouble(),
                  min: 0.0,
                  max: 255.0,
                  divisions: 100,
                ),

              ],
            )
          );
        } else {
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
                      topLeft: Radius.circular( switchObject.value ? 29 : 0),
                      bottomRight: Radius.circular(switchObject.value ? 29 : 0),

                      topRight: Radius.circular( switchObject.value ? 0 : 29 ),
                      bottomLeft: Radius.circular( switchObject.value ? 0 : 29 ),
                    ),),
                  )
                  ),
                ],
              )
            );
    }
  }
}