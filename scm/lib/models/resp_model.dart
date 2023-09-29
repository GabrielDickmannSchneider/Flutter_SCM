import 'package:scm/repositories/resp_repository.dart';

class RespModel {
  late String nome;
  late String email;
  late String senha;
  late String endereco;
  late String telefone;
  late String cpf;
  late String nomeFilho;
  late String emailFilho;
  late int nivPermissao;

  RespModel({required this.email, required this.senha});

  RespModel.empty()
      : email = '',
        senha = '';

  RespModel.fromJson(Map<String, dynamic> json) {
    nome = json["nome_resp"] ?? "";
    email = json["email_resp"] ?? "";
    senha = json["senha_resp"] ?? "";
    endereco = json["endereco_resp"] ?? "";
    telefone = json["telefone_resp"] ?? "";
    cpf = json["cpf_resp"] ?? "";
    nomeFilho = json["nome"] ?? "";
    emailFilho = json["email"] ?? "";
    nivPermissao = json['niv_permissao'] ?? 0;
  }

  bool mesmoResp(RespModel resp) {
    return ((email == resp.email) && (senha == resp.senha));
  }

  Future<bool> verificarLogin() async {
    RespModel respLogin = RespModel(email: email, senha: senha);

    try {
      List<RespModel> listaResp = await RespRepository.getResp(respLogin);

      for (var resp in listaResp) {
        if (resp.mesmoResp(respLogin)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
