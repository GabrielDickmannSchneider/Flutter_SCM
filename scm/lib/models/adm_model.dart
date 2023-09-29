import 'package:scm/repositories/adm_repository.dart';

class AdmModel {
  late String nome;
  late String email;
  late String senha;
  late int nivPermissao;

  AdmModel({required this.email, required this.senha});

  AdmModel.empty()
      : email = "",
        senha = "";
  
  AdmModel.fromJson(Map<String, dynamic> json) {
    nome = json["nome_adm"] ?? "";
    email = json["email_adm"] ?? "";
    senha = json["senha_adm"] ?? "";
    nivPermissao = json["niv_permissao"] ?? 0;
  }

  bool mesmoAdm(AdmModel adm) {
    return ((email == adm.email) && (senha == adm.senha));
  }

  Future<bool> verificarLogin() async {
    AdmModel admLogin = AdmModel(email: email, senha: senha);
    try {
      List<AdmModel> listUser = await AdmRepository.getADM(admLogin);
      for (var resp in listUser) {
        if (resp.mesmoAdm(admLogin)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
