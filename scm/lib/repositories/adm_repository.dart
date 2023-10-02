import 'dart:convert';
import 'package:scm/models/adm_model.dart';
import 'package:http/http.dart' as http;

class AdmRepository {
  static Future<List<AdmModel>> getADM(AdmModel admLogin) async {
    List<AdmModel> listAdm = [];
    try {
      Uri uri = Uri.parse("https://9f65-177-73-136-51.ngrok-free.app/adms");

      http.Response vrResponse = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (vrResponse.statusCode == 200) {
        List<Map<String, dynamic>> vrUsers =
            List<Map<String, dynamic>>.from(jsonDecode(vrResponse.body));

        for (var vrItem in vrUsers) {
          AdmModel vrUser = AdmModel.fromJson(vrItem);

          if (vrUser.mesmoAdm(admLogin)) {
            AdmModel fetchedAdm = await getAdmByEmail(vrUser.email);
            listAdm.add(fetchedAdm);
          }
        }
        return listAdm;
      } else {
        throw ("Erro na solicitação. Código de status: ${vrResponse.statusCode}");
      }
    } catch (e) {
      throw ("Erro ao fazer a solicitação HTTP: $e");
    }
  }

  static Future<AdmModel> getAdmByEmail(String admEmail) async {
    try {
      Uri uri = Uri.parse(
          "https://9f65-177-73-136-51.ngrok-free.app/adm?email=$admEmail"); // Substitua pela URL real da sua API

      http.Response response = await http
          .get(uri, headers: {"ngrok-skip-browser-warning": "accept"});

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> listaUsuarios =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));

        for (var usuarioJson in listaUsuarios) {
          AdmModel adm = AdmModel.fromJson(usuarioJson);

          // ignore: unrelated_type_equality_checks
          if (adm.email == AdmModel) {
            // Verifica se o nome do usuário coincide com o userName solicitado
            return adm;
          }
        }
      } else {
        throw ("Erro na solicitação. Código de status: ${response.statusCode}");
      }
    } catch (e) {
      throw ("Erro ao fazer a solicitação HTTP: $e");
    }
    return AdmModel.empty();
  }
}
