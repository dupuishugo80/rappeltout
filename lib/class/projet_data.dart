import 'dart:convert';

import 'package:rappeltout/back_function/projet.dart';
import 'package:rappeltout/class/projet.dart';

class projectData{
  static List<Projet> buildList(String jsondata){
    List<Projet> list = [];
    var jsonDecode = json.decode(jsondata) as List<dynamic>;
    list = jsonDecode.map((element) => Projet.fromJson(element)).toList();
    return list;
  }
}