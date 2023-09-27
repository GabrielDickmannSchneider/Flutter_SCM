import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scm/models/situacao_model.dart';
import 'package:scm/models/user_model.dart';

class UserRepository {
  static Future<List<UserModel>> getUsers(UserModel userLogin) async {
    List<UserModel> listUser = [];
    try {
      Uri uri = Uri.parse("https://5175-177-73-136-51.ngrok-free.app/users");

      http.Response vrResponse = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (vrResponse.statusCode == 200) {
        List<Map<String, dynamic>> vrUsers =
            List<Map<String, dynamic>>.from(jsonDecode(vrResponse.body));

        for (var vrItem in vrUsers) {
          UserModel vrUser = UserModel.fromJson(vrItem);

          if (vrUser.mesmoUsuario(userLogin)) {
            // Chama o método getUserByName para buscar os detalhes do usuário pelo nome
            UserModel fetchedUser = await getUserByEmail(vrUser.email);
            listUser.add(fetchedUser);
          }
        }
        return listUser;
      } else {
        throw ("Erro na solicitação. Código de status: ${vrResponse.statusCode}");
        //print("Erro na solicitação. Código de status: ${vrResponse.statusCode}");
      }
    } catch (e) {
      throw("Erro ao fazer a solicitação HTTP: $e");
    }
  }

  static Future<UserModel> getUserByEmail(String userEmail) async {
    try {
      Uri uri = Uri.parse(
          "https://5175-177-73-136-51.ngrok-free.app/user?email=$userEmail"); // Substitua pela URL real da sua API

      http.Response response = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> listaUsuarios =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));

        for (var usuarioJson in listaUsuarios) {
          UserModel usuario = UserModel.fromJson(usuarioJson);

          if (usuario.email == userEmail) {
            // Verifica se o nome do usuário coincide com o userName solicitado
            return usuario;
          }
        }
      } else {
        throw("Erro na solicitação. Código de status: ${response.statusCode}");
      }      
    } catch (e) {
      throw("Erro ao fazer a solicitação HTTP: $e");
    }
    return UserModel.empty();
  }

  static Future<List<SituacaoModel>> getSituation(String userEmail) async {
    try {
      Uri uri = Uri.parse(
          "https://5175-177-73-136-51.ngrok-free.app/situation?email=$userEmail"); // Substitua pela URL real da sua API

      http.Response response = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (response.statusCode == 200) {
        List listSituacao = jsonDecode(response.body);
  
        List<SituacaoModel> situacoes = [];

        for (var situationJson in listSituacao) {
          //print('situationJson> ${situationJson}');
          // print('${situationJson['checagem_escola']} - ${situationJson['checagem_escola'].runtimeType}');
          // print('${situationJson['checagem_sala']} - ${situationJson['checagem_sala'].runtimeType}');
          //print('${situationJson['data_ponto']} - ${situationJson['data_ponto'].runtimeType}');
          //print('${situationJson['hora_ponto']} - ${situationJson['hora_ponto'].runtimeType}');
          //var teste = '${situationJson['data_ponto'].toString().split('T')[0]} ${situationJson['hora_ponto']}';
          //print(teste);
          //print('${DateTime.parse(situationJson['data_ponto'])} - ${DateTime.parse(situationJson['data_ponto']).runtimeType}');
          //print('${DateTime.tryParse(teste)} - ${DateTime.tryParse(teste).runtimeType}');
  
          SituacaoModel situacao = SituacaoModel.fromJson(situationJson);
          //print('situacao>${situacao}');
          situacoes.add(situacao);
        }
        return situacoes;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}