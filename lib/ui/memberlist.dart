import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rappeltout/back_function/projet.dart';
import 'package:rappeltout/class/member_data.dart';
import 'package:rappeltout/ui/projet.dart';

import '../class/member.dart';
import '../class/projet.dart';
import 'add_user.dart';

class memberList extends StatefulWidget {
  final projet;
  final isAdmin;
  const memberList({Key? key, required this.projet, required this.isAdmin}) : super(key: key);

  @override
  State<memberList> createState() => _memberListState();
}

class _memberListState extends State<memberList> {
  late Projet _projet;
  bool _chargementTermine = false;
  late bool isAdmin;

  List<Member> _allmember = [];
  @override
  void initState() {
    super.initState();
    _initialiser();
  }

  Future<void> _initialiser() async {
    _projet = widget.projet;
    isAdmin = widget.isAdmin;
    _allmember = memberData.buildList(await fetchAllMember(_projet.id.toString()));
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
          "Liste des membres",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        leading: MaterialButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => projetPage(projet: _projet, isAdmin: isAdmin)));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 22,
          ),
        ),
        actions: [
          isAdmin ? Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: MaterialButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => addUser(projet: _projet)));
              },
              child: Icon(
                  Icons.person_add_outlined, color: Color(0xffffffff), size: 22),
            ),
          ): Container(),
        ],
      ),
      body:
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _allmember.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff4c4c4c),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: _allmember[index].username,
                              style: _allmember[index].id_role == 1
                                  ? TextStyle(
                                color: Color(0xffff9200),
                              )
                                  : _allmember[index].id_role == 2
                                  ? TextStyle(
                                color: Color(0xff169b81),
                              )
                                  : TextStyle(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          _allmember[index].role,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff4c4c4c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                        child: MaterialButton(
                          onPressed: () async {
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Membre supprimé",
                              desc: "Le membre a bien été retiré du projet.",
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
                            await removeMember(_projet.id, _allmember[index].id);
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
                            "Supprimer",
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
                ),
              );
            },
          ),
    ): Center(
      child: CircularProgressIndicator(),
    );
  }
}
