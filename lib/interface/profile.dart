import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:clinica_sorriso/main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}


FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser firebaseUser;
bool isLoading = false;


class _ProfileState extends State<Profile> {

  String _userName = null;
  String _photoUrl = null;
  String _userEmail = null;

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();

    if(_userName == null) {
      Future.delayed(Duration(microseconds: 1)).then((_) async{
        FirebaseUser user = await _auth.currentUser();

        setState(() {
          _userName = user.displayName;
          _photoUrl = user.photoUrl;
          _userEmail = user.email;
        });
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();
    
    _googleLogOut() async{
      googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                      ]
                    ),
                    width: width - 100,
                    height: height - 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 70.0,bottom: 45.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF2699FB).withOpacity(0.09),
                                          spreadRadius: 36.0,
                                          offset: Offset(0, 0)),
                                      BoxShadow(
                                          color: Color(0xFF2699FB).withOpacity(0.09),
                                          spreadRadius: 18.0,
                                          offset: Offset(0, 0))
                                    ],
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            _photoUrl)
                                    )
                                ),
                                width: 120.0,
                                height: 120.0,
                              ),

                            ),
                            Text(_userName.toUpperCase(),
                              style: TextStyle(color: Color(0xFF7FC4FD), fontFamily: 'OpenSans', fontSize: 20.0, fontStyle: FontStyle.normal),
                            ),
                            RaisedButton(
                              onPressed: _googleLogOut,
                              child: Text('Sair'),
                            )
                          ],

                        ),
                      ],
                    ),
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
