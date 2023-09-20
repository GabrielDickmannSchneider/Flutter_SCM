import 'dart:convert';
import 'package:scm/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:scm/models/situacao_model.dart';

class UserRepository {
  static Future<UserModel> getUsers(UserModel userLogin) async {
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

            return fetchedUser;
          }
        }
      } else {
        throw ("Erro na solicitação. Código de status: ${vrResponse.statusCode}");
        //print("Erro na solicitação. Código de status: ${vrResponse.statusCode}");
      }
    } catch (e) {
      throw("Erro ao fazer a solicitação HTTP: $e");
    }
    return UserModel.empty();
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
          "https://5175-177-73-136-51.ngrok-free.app/situation?emai=$userEmail"); // Substitua pela URL real da sua API

      http.Response response = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (response.statusCode == 200) {
        List<dynamic> listSituacao = jsonDecode(response.body);
        List<SituacaoModel> situacoes = [];

        for (var situationJson in listSituacao) {
          SituacaoModel situacao = SituacaoModel.fromJson(situationJson);
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