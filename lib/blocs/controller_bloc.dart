import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bhawan/models/SwitchModel.dart';
import 'package:w3c_event_source/w3c_event_source.dart';

class ControllerBloc extends ChangeNotifier{
  final String token;
  var _subscription;
  List<SwitchModel> _switches = [];

  ControllerBloc(this.token){
    init();
  }

  List<SwitchModel> get switches => _switches;

  List<SwitchModel> _toSwitchModelList(String message){
    List<SwitchModel> switches = [];
    jsonDecode(message).forEach((key, value) {
      switches.add(SwitchModel(switchName: key, value: value, isDimmer: key[0] == 'd'));
    });
//    print(switches);
    return switches;
  }

  void init() async {
    final url = Uri.parse('http://bhawan.co.in/sse/' + this.token + '/');
    final events = EventSource(url);

    _subscription = events.events.listen((MessageEvent message) {
      _switches = _toSwitchModelList(message.data);
      notifyListeners();
    });
  }

  void updateSwitch(newState) {
    final url = Uri.parse('http://bhawan.herokuapp.com/api/user/' + this.token + '/');
    http.patch(url, body: jsonEncode(newState));
  }


  void closeListener(){
    _subscription.close();
  }
}