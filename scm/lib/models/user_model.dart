class UserModel {
  late int codEscola;
  late int codResp;
  late String codRfid;
  late int nivPermissao;
  late int codUsuario;
  late String cpf;
  late String nome;
  late String turma;
  late String endereco;
  late String senha;
  late String email;

  UserModel({ required this.email, required this.senha });

  UserModel.empty(): email = '', senha = '';

  UserModel.fromJson(Map<String, dynamic> json) {
    codEscola = json["cod_escola"] ?? 0;
    codResp = json["cod_resp"] ?? 0;
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
}