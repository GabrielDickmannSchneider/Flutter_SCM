class SituacaoModel {
  late int checagemEscola;
  late int checagemSala;
  late DateTime dataPonto;
  late DateTime horaPonto;

  SituacaoModel({
    required this.checagemEscola,
    required this.checagemSala,
    required this.dataPonto,
    required this.horaPonto,
  });

  Map<String, dynamic> toMap() {
    return {
      'checagem_escola': checagemEscola,
      'checagem_sala': checagemSala,
      'data_ponto': dataPonto.toIso8601String(),
      'hora_ponto': horaPonto.toIso8601String(),
    };
  }

  factory SituacaoModel.fromJson(Map<String, dynamic> json) {
    return SituacaoModel(
      checagemEscola: json['checagem_escola'] ?? 0,
      checagemSala: json['checagem_sala'] ?? 0,
      dataPonto: DateTime.parse(json['data_ponto']),
      horaPonto: DateTime.parse(json['hora_ponto']),
    );
  }
}
