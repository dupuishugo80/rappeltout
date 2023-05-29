import 'dart:convert';

import 'package:rappeltout/back_function/projet.dart';
import 'package:rappeltout/class/member.dart';
import 'package:rappeltout/class/projet.dart';

class memberData{
  static List<Member> buildList(String jsondata){
    List<Member> list = [];
    var jsonDecode = json.decode(jsondata) as List<dynamic>;
    list = jsonDecode.map((element) => Member.fromJson(element)).toList();
    return list;
  }
}