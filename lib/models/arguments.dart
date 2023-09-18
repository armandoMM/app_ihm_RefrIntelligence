import 'dart:convert';

Arguments argumentsFromJson(String str) => Arguments.fromJson(json.decode(str));

String argumentsToJson(Arguments data) => json.encode(data.toJson());

class Arguments {
  Arguments({
    this.idHistorico,
    required this.fechaIngreso,
    required this.fechaCaducidad,
    required this.cantidad,
    required this.idVerdura,
  });

  final int idVerdura;
  final int? idHistorico;
  final String fechaIngreso, fechaCaducidad, cantidad;

  factory Arguments.fromJson(Map<String, dynamic> json) => Arguments(
        idHistorico: json["idHistorico"],
        fechaIngreso: json["fechaIngreso"],
        fechaCaducidad: json["fechaCaducidad"],
        cantidad: json["cantidad"].toString(),
        idVerdura: json["idVerdura"],
      );

  Map<String, dynamic> toJson() => {
        "idHistorico": idHistorico,
        "fechaIngreso": fechaIngreso,
        "fechaCaducidad": fechaCaducidad,
        "cantidad": cantidad,
        "idVerdura": idVerdura,
      };
}
