import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rappeltout/back_function/tache.dart';
import 'package:rappeltout/class/tache.dart';
import 'package:rappeltout/class/tache_data.dart';
import 'package:rappeltout/ui/add_tache.dart';
import 'package:rappeltout/ui/add_user.dart';
import 'package:rappeltout/ui/memberlist.dart';
import 'package:rappeltout/ui/projectlist.dart';

import '../back_function/projet.dart';
import '../class/projet.dart';
import '../class/projet_data.dart';
import 'login.dart';


class projetPage extends StatefulWidget {
  final projet;
  final isAdmin;
  const projetPage({Key? key, required this.projet, required this.isAdmin}) : super(key: key);

  @override
  State<projetPage> createState() => _projetPageState();
}

class _projetPageState extends State<projetPage> {
  late Projet _projet;
  late bool isAdmin;
  bool _chargementTermine = false;

  List<Tache> _tache = [];

  @override
  void initState() {
    super.initState();
    _initialiser();
  }

  Future<void> _initialiser() async {
    _projet = widget.projet;
    isAdmin = widget.isAdmin;
    FlutterSecureStorage st = FlutterSecureStorage();
    await st.delete(key: 'idprojet');
    await st.write(key: 'idprojet', value: _projet.id.toString());
    _tache = tacheData.buildList(await fetchTache((await st.read(key: "idprojet")).toString()));
    setState(() {
      _chargementTermine = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _chargementTermine ? Scaffold(
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
          _projet.nom,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        leading: MaterialButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => projectList()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 22,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: 
            MaterialButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => memberList(projet: _projet, isAdmin: isAdmin)));
              },
              child: Icon(
                  Icons.supervisor_account, color: Color(0xffffffff), size: 22),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
            child: MaterialButton(
              onPressed: () async {
                FlutterSecureStorage st = FlutterSecureStorage();
                await st.deleteAll();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
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
                MaterialButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => addTache(projet: _projet, isAdmin: isAdmin)));
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
                                  "Ajouter une tâche",
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
                ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _tache.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.article,
                                    color: Color(0xff3a57e8),
                                    size: 50,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        _tache[index].nom,
                                                        textAlign: TextAlign.start,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 16,
                                                          color: Color(0xff000000),
                                                        ),
                                                      ),
                                                    ),
                                                    Checkbox(
                                                      onChanged: (value) {
                                                        updateStateTache(_tache[index].id);
                                                        Alert(
                                                            context: context,
                                                            type: AlertType.success,
                                                            title: "Tâche mise à jour !",
                                                            desc: "La tâche a été mise à jour avec succès.",
                                                            buttons: [
                                                              DialogButton(
                                                                child: Text(
                                                                  "Fermer",
                                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                                ),
                                                                onPressed: () => Navigator.pop(context),
                                                                width: 120,
                                                              )
                                                            ],
                                                          ).show();
                                                      },
                                                      activeColor: Color(0xff3a57e8),
                                                      autofocus: false,
                                                      checkColor: Color(0xffffffff),
                                                      hoverColor: Color(0x42000000),
                                                      splashRadius: 20,
                                                      value: false,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    _tache[index].deadline,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 14,
                                                      color: Color(0xff393939),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4, horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Color(0x343a57e8),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(4.0),
                                                  ),
                                                  child: Text(
                                                    _tache[index].etat == 1 ? "En cours" : (_tache[index].etat == 2 ? "Terminée" : _tache[index].etat.toString()),
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                      color: Color(0xff3a57e8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ],
            ),
          ),
        ),
      ),
    ): Center(
      child: CircularProgressIndicator(),
    );
  }
}

