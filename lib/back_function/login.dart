import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rappeltout/class/user.dart';
import 'package:rappeltout/ui/projectlist.dart';

Future<void> fetchUser(BuildContext context, String email, String password) async {
  FlutterSecureStorage storage = FlutterSecureStorage();
  final response = await http
      .post(Uri.parse('http://localhost:7777/login'),
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password
    }),);
  await storage.deleteAll();
  if (response.statusCode == 200) {
    User u = User.fromJson(jsonDecode(response.body));
    await storage.write(key: "log", value: "true");
    await storage.write(key: "username", value: u.username);
    await storage.write(key: "id", value: u.id.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => projectList()));
  }else{
    await storage.write(key: "log", value: "false");
  }
}
