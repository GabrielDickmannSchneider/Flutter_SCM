import 'package:scm/repositories/user_repository.dart';

class UserModel {
  late String escola;
  late String resp;
  late String codRfid;
  late int nivPermissao;
  late int codUsuario;
  late String cpf;
  late String nome = "";
  late String turma;
  late String endereco;
  late String senha;
  late String email;

  UserModel({required this.email, required this.senha});

  UserModel.empty()
      : email = '',
        senha = '';

  UserModel.fromJson(Map<String, dynamic> json) {
    escola = json["nome_escola"] ?? "";
    resp = json["nome_resp"] ?? "";
    codRfid = json["cod_rfid"] ?? "";
    nivPermissao = json["niv_permissao"] ?? 0;
    codUsuario = json["cod_usuario"] ?? 0;
    cpf = json["cpf"] ?? "";
    nome = json["nome"] ?? "";
    turma = json["turma"] ?? "";
    endereco = json["endereco"] ?? "";
    senha = json["senha"] ?? "";
    email = json["email"] ?? "";
  }

  bool mesmoUsuario(UserModel user) {
    return ((email == user.email) && (senha == user.senha));
  }

  Future<bool> verificarLogin() async {
    UserModel userLogin = UserModel(email: email, senha: senha);
    try {
      List<UserModel> listUser = await UserRepository.getUsers(userLogin);
      for (var resp in listUser) {
        if (resp.mesmoUsuario(userLogin)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
