import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class mysqlConn {
  Future lista(String table) async {
    // Open a connection (testdb should already exist)

    final conn = await MySqlConnection.connect(new ConnectionSettings(
        host: 'br432.hostgator.com.br',
        port: 3306,
        user: 'ebrah863_app',
        password: 'faverodonin1020',
        db: 'ebrah863_app'));

    var results =
        await conn.query('select username, password from $table where id = 1');
    for (var row in results) {
      print('username: ${row[0]}, password: ${row[1]}');
    }

    // Finally, close the connection
    await conn.close();
  }

  Future createTable(String table) async {
    final conn = await MySqlConnection.connect(new ConnectionSettings(
        host: 'br432.hostgator.com.br',
        port: 3306,
        user: 'ebrah863_app',
        password: 'faverodonin1020',
        db: 'ebrah863_app'));
    // Create a table
    await conn.query(
        'CREATE TABLE $table (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, username varchar(255), email varchar(255), password varchar(255), uid varchar(255), UNIQUE (uid))');
    await conn.close();
  }

  Future saveUser(
      String username, String email, String password, String uid) async {
    final conn = await MySqlConnection.connect(new ConnectionSettings(
        host: 'br432.hostgator.com.br',
        port: 3306,
        user: 'ebrah863_app',
        password: 'faverodonin1020',
        db: 'ebrah863_app'));

    var result = await conn.query(
        'insert into users (username, email, password, uid) VALUES ( "$username" , "$email" , "$password" , "$uid" )');
    conn.close();
  }

  Future<Map> getScheduling() async {
    /*
    final conn = await MySqlConnection.connect(new ConnectionSettings(
        host: 'br432.hostgator.com.br',
        port: 3306,
        user: 'ebrah863_app',
        password: 'faverodonin1020',
        db: 'ebrah863_app'));
    var result =
        await conn.query('SELECT * FROM agendamentos WHERE users_uid = "$uid"');

    conn.close();
    return result;
    */
    //192.168.0.5/painel_apps/clinica_sorriso/cake/agendamentos/user/

    http.Response response; // define response como responsavel por receber o resultado
    response = await http.get("http://192.168.0.5/painel_apps/clinica_sorriso/cake/agendamentos/user/Wub5JGopuSVhdiVbhGRCbapwNF73.json"); // response espera resposta da api com os gifs mais vistos
    return json.decode(response.body); // retorna um array com os dados


  }
}
