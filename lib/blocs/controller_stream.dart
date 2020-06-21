import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bhawan/models/SwitchModel.dart';
import 'package:w3c_event_source/event_source.dart';

class ControllerStream{
  final token;
  List<SwitchModel> _switches = [];
  ControllerStream(this.token){
    init(token);
  }

  void init(String token) async {
    final url = Uri.parse('http://bhawan.co.in/sse/a73b38791a2a49cda5cb38e61076a4eb/');
    final events = EventSource(url);

    final subscription = events.events.listen((MessageEvent message) {
      _switches = _toSwitchModelList(message.data);
      _controller.sink.add(_switches);
    });


  }
  final _controller = StreamController<List<SwitchModel>>();
  Stream<List<SwitchModel>> get switches => _controller.stream.asBroadcastStream();

  List<SwitchModel> _toSwitchModelList(String message){
    List<SwitchModel> switches = [];
    jsonDecode(message).forEach((key, value) {
      switches.add(SwitchModel(switchName: key, value: value, isDimmer: key[0] == 'd'));
    });
//    print(switches);
    return switches;
  }



}