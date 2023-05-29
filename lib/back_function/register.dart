import 'dart:convert';
import 'package:http/http.dart' as http;

void createAccount(String username, String email, String motdepasse) async{
  final response = await http
      .post(Uri.parse('http://localhost:7777/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'motdepasse': motdepasse,
    }),);
}