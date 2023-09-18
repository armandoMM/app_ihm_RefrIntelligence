// ignore: file_names
import 'dart:convert';

ArgsVerduras argsFromJson(String str) => ArgsVerduras.fromJson(json.decode(str));

String argsToJson(ArgsVerduras data) => json.encode(data.toJson());

class ArgsVerduras {
  ArgsVerduras({
    required this.idVerdura,
    required this.nombre,
  });

  final int idVerdura;
  final String nombre;

  factory ArgsVerduras.fromJson(Map<String, dynamic> json) => ArgsVerduras(
        idVerdura: json["idVerdura"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idVerdura": idVerdura,
        "nombre": nombre,
      };
}
