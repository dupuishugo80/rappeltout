import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rappeltout/back_function/projet.dart';
import 'package:rappeltout/ui/add_projet.dart';
import 'package:rappeltout/ui/login.dart';
import 'package:rappeltout/ui/projet.dart';

import '../class/projet.dart';
import '../class/projet_data.dart';

class projectList extends StatefulWidget {
  const projectList({ Key? key }) : super(key: key);

  @override
  State<projectList> createState() => _projectListState();
}

class _projectListState extends State<projectList> {
  late final FlutterSecureStorage st;

  Future<String?> _getName() async {
    FlutterSecureStorage st = FlutterSecureStorage();
    var username = st.read(key: "username");
    return username;
  }

  List<Projet> _projet = [];
  List<Projet> _projetparticipation = [];
  bool _chargementTermine = false;

  @override
  void initState() {
    super.initState();
    _initialiser();
  }

  Future<void> _initialiser() async {
    FlutterSecureStorage st = FlutterSecureStorage();
    _projet = projectData.buildList(await fetchProjet((await st.read(key: "id")).toString()));
    _projetparticipation = projectData.buildList(await fetchProjetParticipation((await st.read(key: "id")).toString()));
    setState(() {
      _chargementTermine = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _chargementTermine ?  Scaffold(
      body: FutureBuilder<String?>(
          future: _getName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Color(0xffffffff),
                appBar: AppBar(
                  elevation: 4,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(0xff3a57e8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  title: Text(
                    "Mes projets",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xffffffff),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => addProjet()));
                        },
                        child: Icon(
                            Icons.add, color: Color(0xffffffff), size: 22),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                      child: MaterialButton(
                        onPressed: () async {
                          FlutterSecureStorage st = FlutterSecureStorage();
                          await st.deleteAll();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        color: Color(0xffFF0000),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Color(0xffFF0000), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Déconnexion",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xffFFFFFF),
                        height: 40,
                        minWidth: 140,
                      ),
                    ),
                  ],
                ),
                body: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Bienvenue ${snapshot.data}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                          ),

                          Text(
                            "Mes projets :",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                          ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _projet.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => projetPage(projet: _projet[index], isAdmin: true)));
                                },
                                color: Color(0xff3a57e0),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                      color: Color(0xff808080), width: 1),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  _projet[index].nom,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                textColor: Color(0xffFFFFFF),
                                height: 40,
                                minWidth: 140,
                              ),
                            );
                          },
                        ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Text(
                              "Projets dont je suis membre :",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _projetparticipation.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => projetPage(projet: _projet[index], isAdmin: false)));
                                  },
                                  color: Color(0xff3a57e0),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color: Color(0xff808080), width: 1),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    _projetparticipation[index].nom,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  textColor: Color(0xffFFFFFF),
                                  height: 40,
                                  minWidth: 140,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ) : Center(
      child: CircularProgressIndicator(),
    );
  }
}