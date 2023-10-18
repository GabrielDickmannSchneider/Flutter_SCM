class HorasModel {
  late DateTime dia;
  late String minHora;
  late String maxHora;

  HorasModel ({
    required this.dia,
    required this.minHora,
    required this.maxHora,
  });

  Map<String, dynamic> toMap() {
    return {
      'dia': dia.toIso8601String(),
      'minHora': minHora,
      'maxHora': maxHora
    };
  }

  factory HorasModel.fromJson(Map<String, dynamic> json) {
    return HorasModel(
      dia: DateTime.parse(json['dia'].toString().split('T')[0]), 
      minHora: json['minHora'], 
      maxHora: json['maxHora']
      );
  }
}