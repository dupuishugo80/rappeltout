import 'dart:convert';

import 'package:rappeltout/class/tache.dart';

class tacheData{
  static List<Tache> buildList(String jsondata){
    List<Tache> list = [];
    var jsonDecode = json.decode(jsondata) as List<dynamic>;
    list = jsonDecode.map((element) => Tache.fromJson(element)).toList();
    return list;
  }
}