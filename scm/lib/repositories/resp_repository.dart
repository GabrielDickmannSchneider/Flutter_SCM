import 'dart:convert';
import 'package:scm/models/resp_model.dart';
import 'package:http/http.dart' as http;

class RespRepository {
  static Future<List<RespModel>> getResp(RespModel respLogin) async {
    List<RespModel> listResp = [];
    try {
      Uri uri = Uri.parse("https://5175-177-73-136-51.ngrok-free.app/resps");

      http.Response vrResponse = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (vrResponse.statusCode == 200) {
        List<Map<String, dynamic>> vrUsers =
            List<Map<String, dynamic>>.from(jsonDecode(vrResponse.body));

        for (var vrItem in vrUsers) {
          RespModel vrUser = RespModel.fromJson(vrItem);

          if (vrUser.mesmoResp(respLogin)) {
            // Chama o método getUserByName para buscar os detalhes do usuário pelo email
            RespModel fetchedResp = await getRespByEmail(vrUser.email);
            listResp.add(fetchedResp);
          }
        }
        return listResp;
      } else {
        throw ("Erro na solicitação. Código de status: ${vrResponse.statusCode}");
      }
    } catch (e) {
      throw ("Erro ao fazer a solicitação HTTP: $e");
    }
  }

  static Future<RespModel> getRespByEmail(String respEmail) async {
    try {
      Uri uri = Uri.parse(
          "https://5175-177-73-136-51.ngrok-free.app/resp?email=$respEmail"); // Substitua pela URL real da sua API

      http.Response response = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> listaUsuarios =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));

        for (var usuarioJson in listaUsuarios) {
          RespModel resp = RespModel.fromJson(usuarioJson);

          if (resp.email == respEmail) {
            // Verifica se o nome do usuário coincide com o userName solicitado
            return resp;
          }
        }
      } else {
        throw ("Erro na solicitação. Código de status: ${response.statusCode}");
      }
    } catch (e) {
      throw ("Erro ao fazer a solicitação HTTP: $e");
    }
    return RespModel.empty();
  }
}
