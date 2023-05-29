import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchProjet(String id) async {
  int indtofind = int.parse(id);
  final response = await http
      .get(Uri.parse('http://localhost:7777/projet/${indtofind}'));

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

Future<String> fetchProjetParticipation(String id) async {
  int indtofind = int.parse(id);
  final response = await http
      .get(Uri.parse('http://localhost:7777/projet/participation/${indtofind}'));

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

Future<void> createProject(String nom, String id) async{
  final response = await http
      .post(Uri.parse('http://localhost:7777/projet'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nom': nom,
      'id': id
    }),);

}

Future<void> addUserToProject(String username, String id) async{
  final response = await http
      .post(Uri.parse('http://localhost:7777/projet/addMember'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'id': id
    }),);

}

Future<String> fetchAllMember(String id) async {
  int indtofind = int.parse(id);
  final response = await http
      .get(Uri.parse('http://localhost:7777/projet/member/${indtofind}'));

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

Future<void> removeMember(int idprojet, int idmember) async {
  await http.get(Uri.parse('http://localhost:7777/projet/${idprojet}/remove/${idmember}'));
}