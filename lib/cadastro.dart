import 'package:flutter/material.dart';
import 'package:clinica_sorriso/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    bool _obscureText = true;

    final _formKey = GlobalKey<FormState>();

    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(
              color: Color(0xFF2699FB),
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w400,
              fontSize: 20.0),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF1F9FF),
        elevation: 0.0,
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
      body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                        ),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "E-mail",
                        hintStyle: TextStyle(
                            color: Color(0xFF2699FB),
                            fontFamily: 'OpenSans',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.white)),
                        suffixIcon: Icon(Icons.check_circle),
                        labelText: "Seu E-mail",
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                          };
                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
                      },
                      color: Color(0xFF2699FB),
                      child: Text(
                        "Criar conta",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300),
                      ),
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário criado com sucesso!"),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }


}
