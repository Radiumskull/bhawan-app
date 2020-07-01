import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends ChangeNotifier{
  String _token;
  bool _loading = false;
  bool _darkMode = false;

  AuthBloc(){
    init();
  }

  void init() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    final temp = userData.getString('auth_token');
    final isDark = userData.getBool('darkmode');
    if(temp != null){
      _token = temp;
    }
    if(isDark != null){
      _darkMode = isDark;
    }
    notifyListeners();
  }

  String _error;

  get error => _error;
  get token => _token;
  get loading => _loading;
  get darkMode => _darkMode;

  set token(String token){
    _token = token;
    notifyListeners();
  }

  void setLoading(){
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> login(email, password) async {
    String url = 'http://bhawan.co.in/api/login/';
    try {
      setLoading();
      final res = await http.post(url, body : jsonEncode({
        'email' : email,
        'password' : password
      }));
      setLoading();
      final body = jsonDecode(res.body);
      if(body['error'] != null) _error = body['error'];

      SharedPreferences userData = await SharedPreferences.getInstance();
      _token = body['token'];
      await userData.setString('auth_token', body['token']);
    } catch (e) {
      _error = "Error Connecting to Server.";
    }
    notifyListeners();
  }

  Future<void> register(email, phone) async {
    String url = "http://bhawan.co.in/api/register/";
    try{
      setLoading();
      final res = await http.post(url, body : jsonEncode({
        'email' : email,
        'phone_number' : int.parse(phone)
      }));
      setLoading();
      final body = jsonDecode(res.body);
      print(body);
      if(body['error'] != null) _error = body['error'];
    }catch(e){
      _error = "Error Connecting to Server.";
    }
    notifyListeners();
  }

  void clearError(){
    _error = null;
    notifyListeners();
  }

  void changeUI(bool mode) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    _darkMode = mode;
    await userData.setBool('darkmode', mode);
    notifyListeners();
  }



  void logout() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    await userData.setString('auth_token', null);
    _token = null;
    _error = null;
    notifyListeners();
  }
}

