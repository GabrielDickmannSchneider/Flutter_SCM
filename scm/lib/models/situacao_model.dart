class SituacaoModel {
  late String situacao;
  late DateTime dataPonto;
  late String horaPonto;

  SituacaoModel({
    required this.situacao,
    required this.dataPonto,
    required this.horaPonto,
  });

  Map<String, dynamic> toMap() {
    return {
      'situacao': situacao,
      'data_ponto': dataPonto.toIso8601String(),
      'hora_ponto': horaPonto,
    };
  }

  factory SituacaoModel.fromJson(Map<String, dynamic> json) {
    return SituacaoModel(
      situacao: json['situacao'],
      dataPonto: DateTime.parse(json['data_ponto'].toString().split('T')[0]),
      horaPonto: json['hora_ponto']
    );
  }
}
