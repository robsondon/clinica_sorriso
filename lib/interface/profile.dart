import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:clinica_sorriso/main.dart';
import 'package:clinica_sorriso/db/conn.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http; // usado para acessar api



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser firebaseUser;
bool isLoading = false;

final controller = PageController(
  initialPage: 0,
);



class _ProfileState extends State<Profile> {
  String _userName = '';
  String _photoUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCbp8l4-EgY4_ODpGmMkriwuCqWQeKgueCDQzxk0y_XtF5RMomSg';
  String _userEmail = null;
  String _userUid = '';
  @override
  Future initState() {
    // TODO: implement initState
    super.initState();

    if (_userName == '') {
      Future.delayed(Duration(microseconds: 1)).then((_) async {
        FirebaseUser user = await _auth.currentUser();
        setState(() {
          if (user.displayName.length >= 15) {
            _userName = user.displayName.substring(0, 15);
          } else {
            _userName = user.displayName;
          }
          _photoUrl = user.photoUrl;
          _userEmail = user.email;
          _userUid = user.uid;
        });
      });
      _getScheduling().then((map) {});
    }
  }



  Future<Map> _getScheduling() async {
    http.Response
        response; // define response como responsavel por receber o resultado
    response = await http.get(
        "http://192.168.0.5/painel_apps/clinica_sorriso/cake/agendamentos/user/$_userUid.json"); // response espera resposta da api com os gifs mais vistos
    return (convert.jsonDecode(response.body)); // retorna um array com os dados
  }




  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();

    _googleLogOut() async {
      googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child: IconButton(
              onPressed: () {}, //função anonima
              icon: Icon(Icons.home), color: Color(0xFF2699FB),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
              color: Color(0xFFF1F9FF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_location),
              color: Color(0xFFF1F9FF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.help),
              color: Color(0xFFF1F9FF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.brightness_high),
              color: Color(0xFFF1F9FF),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xff0FF2699FB),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "images/logo-white.png",
                    width: 100.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F9FF),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(-6.0, 6.0))
                        ]),
                    width: width - 100,
                    height: height - 200,
                    child: PageView(

                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 70.0, bottom: 45.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF2699FB)
                                                  .withOpacity(0.09),
                                              spreadRadius: 36.0,
                                              offset: Offset(0, 0)),
                                          BoxShadow(
                                              color: Color(0xFF2699FB)
                                                  .withOpacity(0.09),
                                              spreadRadius: 18.0,
                                              offset: Offset(0, 0))
                                        ],
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(_photoUrl))),
                                    width: 120.0,
                                    height: 120.0,
                                  ),
                                ),
                                Text(
                                  _userName.toUpperCase(),
                                  style: TextStyle(
                                      color: Color(0xFF7FC4FD),
                                      fontFamily: 'OpenSans',
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.normal),
                                ),
                                Container(
                                  child: FutureBuilder(
                                    future: _getScheduling(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                        case ConnectionState.none:
                                          return Container(
                                            width: 200.0,
                                            height: 200.0,
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator(
                                              // loadin
                                              valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                                  Colors.lightBlueAccent), //esilo
                                              strokeWidth: 5.0,
                                            ),
                                          );
                                        default: //
                                          if (snapshot.data['data'] == null)
                                            return Column(children: <Widget>[
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 12.0, bottom: 12.0),
                                                  child: Text(
                                                    'Aguardando seu Agendamento',
                                                    style: TextStyle(
                                                        color: Color(0xff2699FB),
                                                        fontFamily: "OpenSans",
                                                        fontSize: 14.0),
                                                  )),
                                              Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10.0),
                                                child: Text(
                                                  'Centro Odontológico Sorriso. \n Avenida Brasil, 6580 - Centro',
                                                  style: TextStyle(
                                                      color: Color(0xff7FC4FD),
                                                      fontFamily: "OpenSans",
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons.access_time),
                                                          color:
                                                          Color(0xff2699FB),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0, right: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(Icons
                                                              .calendar_today),
                                                          color:
                                                          Color(0xff2699FB),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(Icons
                                                              .airline_seat_flat_angled),
                                                          color:
                                                          Color(0xff2699FB),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]); // caso erro retorna um container vazio
                                          else
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 12.0, bottom: 12.0),
                                                    child: Text(
                                                      'Agendamento Confirmado',
                                                      style: TextStyle(
                                                          color: Color(0xff2699FB),
                                                          fontFamily: "OpenSans",
                                                          fontSize: 14.0),
                                                    )),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(bottom: 10.0),
                                                  child: Text(
                                                    'Centro Odontológico Sorriso. \n Avenida Brasil, 6580 - Centro',
                                                    style: TextStyle(
                                                        color: Color(0xff7FC4FD),
                                                        fontFamily: "OpenSans",
                                                        fontSize: 14.0),
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                                Icons.access_time),
                                                            color:
                                                            Color(0xff2699FB),
                                                          ),
                                                          Text(
                                                              snapshot.data['data']
                                                              ['hora'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff2699fb),
                                                                  fontFamily:
                                                                  'OpenSans')),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0, right: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(Icons
                                                                .calendar_today),
                                                            color:
                                                            Color(0xff2699FB),
                                                          ),
                                                          Text(
                                                              snapshot.data['data']
                                                              ['data'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff2699fb),
                                                                  fontFamily:
                                                                  'OpenSans')),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(Icons
                                                                .airline_seat_flat_angled),
                                                            color:
                                                            Color(0xff2699FB),
                                                          ),
                                                          Text(
                                                              snapshot.data['data']
                                                              ['servico'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff2699fb),
                                                                  fontFamily:
                                                                  'OpenSans')),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF2699FB)
                                      .withOpacity(0.09),
                                  spreadRadius: 36.0,
                                  offset: Offset(0, 0)),
                              BoxShadow(
                                  color: Color(0xFF2699FB)
                                      .withOpacity(0.09),
                                  spreadRadius: 18.0,
                                  offset: Offset(0, 0))
                            ],

                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
