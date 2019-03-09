import 'package:flutter/material.dart';
import 'package:clinica_sorriso/login.dart';
import 'package:clinica_sorriso/cadastro.dart';
import 'package:clinica_sorriso/signup_screen.dart';
import 'package:clinica_sorriso/interface/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        backgroundColor: Color(0xFFF1F9FF),
        fontFamily: "OpenSans",
        canvasColor: Color(0xFFF1F9FF),
        cardColor: Color(0xFFF1F9FF),
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryIconTheme: IconThemeData(color: Colors.blueAccent),
        primaryTextTheme: TextTheme(
            title: TextStyle(
                color: Colors.blue
            )
        )
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F9FF),
        elevation: 0.0,
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child:IconButton(
              onPressed: (){},//função anonima
              icon: Icon(Icons.home), color: Color(0xFF2699FB),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child:IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications), color: Color(0xFFF1F9FF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child:IconButton(
              onPressed: (){},
              icon: Icon(Icons.add_location), color: Color(0xFFF1F9FF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child:IconButton(
              onPressed: (){},
              icon: Icon(Icons.help), color: Color(0xFFF1F9FF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.0, right: 9.0),
            child:IconButton(
              onPressed: (){},
              icon: Icon(Icons.brightness_high), color: Color(0xFFF1F9FF),
            ),
          ),

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF1F9FF),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Image.asset(
                "images/logo.png",
                width: 95.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 7.0, bottom: 7.0),
              child: Text(
                "Olá, estamos ansiosos para ajudar no seu atendimento.",
                style: TextStyle(
                  color: Color(0xff7FC4FD),
                  fontSize: 20.0,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset('images/dente-intro.png'),
            Padding(
                padding: EdgeInsets.only(top: 7.0, left: 35.0, right: 35.0),
                child: Text(
                  "Faça seu cadastro para ter todas as infomações sobre suas consultas no Centro Odontológico Sorriso.",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 14.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal),
                  textAlign: TextAlign.center,
                )),
            Container(
              width: 200,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF2699FB).withOpacity(0.15),
                      blurRadius: 10.0,
                      spreadRadius: 4.0,
                      offset: Offset(-6.0, 6.0))
                ],
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                color: Color(0xFF2699FB),
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w300
                  ),
                ),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),

            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF2699FB).withOpacity(0.15),
                      blurRadius: 10.0,
                      spreadRadius: 4.0,
                      offset: Offset(-6.0, 6.0))
                ],
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));},

                color: Color(0xFF2699FB),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w300
                  ),
                ),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),

            ),

          ],
        ),
      ),
    );
  }



    void initState() {
      super.initState();
        FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
          if(firebaseUser.displayName != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          }
        return firebaseUser;
      });
    }

}
