import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthBloc extends ChangeNotifier{
  String _token = "a73b38791a2a49cda5cb38e61076a4eb";
  bool _loading = false;
  String _error;

  get error => _error;
  get token => _token;
  get loading => _loading;

  set token(String token){
    _token = token;
    notifyListeners();
  }
  void setLoading(){
    _loading = !_loading;
    notifyListeners();
  }

  void login(email, password) async {
    String url = 'https://bhawan.herokuapp.com/api/login/';
    try {
      setLoading();
      final res = await http.post(url, body : jsonEncode({
        'email' : email,
        'password' : password
      }));
      setLoading();
      final body = jsonDecode(res.body);
      if(body['error'] != null) _error = body['error'];
      _token = body['token'];
    } catch (e) {
      _error = "Error Connecting to Server.";
    }
    notifyListeners();
  }

  void logout() {
    _token = null;
    _error = null;
    notifyListeners();
  }
}

