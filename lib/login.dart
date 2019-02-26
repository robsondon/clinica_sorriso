import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {
  final Login login;
  Login({this.login});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>  {
  bool _obscureText = true;

  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;


  Future<Null> _facebookLogin() async{
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return result.accessToken;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return result.errorMessage;
        break;
      case FacebookLoginStatus.error:
        return result.errorMessage;
        break;
    }
  }





  Future<FirebaseUser> _ensureLoggedIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await auth.signInWithCredential(credential);
    print("Logado como " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(
                color: Color(0xFF2699FB),
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
                fontSize: 20.0),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFFF1F9FF),
        ),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: height,
            decoration: BoxDecoration(color: Color(0xFFF1F9FF)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Nome de usuário",
                      hintStyle: TextStyle(
                          color: Color(0xFF2699FB),
                          fontFamily: 'OpenSans',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      suffixIcon: Icon(Icons.check_circle),
                      labelText: "Nome de usuário",
                      labelStyle: TextStyle(
                          color: Color(0xFF2699FB),
                          fontFamily: 'OpenSans',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300),
                    ),
                    style: TextStyle(color: Color(0xFF2699FB)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Ex: senha",
                      hintStyle: TextStyle(
                          color: Color(0xFF2699FB),
                          fontFamily: 'OpenSans',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText
                                ? _obscureText = false
                                : _obscureText = true;
                          });
                        },
                      ),
                      labelText: "Sua Senha",
                      labelStyle: TextStyle(
                          color: Color(0xFF2699FB),
                          fontFamily: 'OpenSans',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300),
                    ),
                    style: TextStyle(color: Color(0xFF2699FB)),
                    obscureText: _obscureText,
                  ),
                ),
                Container(
                  width: 250,
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () {},
                    color: Color(0xFF2699FB),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w300),
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),
                ),
                Container(
                  width: 250,
                  height: 48,
                  margin: EdgeInsets.all(5.0),
                  child: RaisedButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Color(0xFF2699fb),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(width: 3, color: Color(0xFF2699FB)),
                    ),
                    onPressed: _facebookLogin,
                    color: Color(0xFFF1F9FF),
                    elevation: 0,
                    label: Text(
                      "Login com Facebook",
                      style: TextStyle(
                          color: Color(0xFF2699FB),
                          fontSize: 20.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 48,
                  margin: EdgeInsets.all(5.0),
                  child: RaisedButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.googlePlusG,
                      color: Color(0xFF2699fb),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(width: 3, color: Color(0xFF2699FB)),
                    ),
                    onPressed: (){
                      _ensureLoggedIn()
                          .then((FirebaseUser user) => print(user))
                          .catchError((e) => print(e));
                    },
                    color: Color(0xFFF1F9FF),
                    elevation: 0,
                    label: Text(
                      "Login com Google",
                      style: TextStyle(
                          color: Color(0xFF2699FB),
                          fontSize: 20.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
