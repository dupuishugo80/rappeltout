import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchTache(String id) async {
  int indtofind = int.parse(id);
  final response = await http
      .get(Uri.parse('http://localhost:7777/projet/${indtofind}/getTache'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<void> createTache(String nom, String deadline, String idprojet) async{
  final response = await http
      .post(Uri.parse('http://localhost:7777/tache'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nom': nom,
      'deadline': deadline,
      'idprojet': idprojet
    }),);

}

Future<void> removeMember(int idprojet, int idmember) async {
  await http.get(Uri.parse('http://localhost:7777/projet/${idprojet}/remove/${idmember}'));
}

Future<void> updateStateTache(int idtache) async {
  await http.get(Uri.parse('http://localhost:7777/tache/${idtache}/updateTache'));
}