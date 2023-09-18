import 'package:app_ihm/models/models.dart';
import 'package:app_ihm/Theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Arguments args;
  final ArgsVerduras? argsVerduras;
  final String nameArgVerduras;
  final double size;
  final bool isList;
  final Function() delate;

  const CustomCard({
    Key? key,
    required this.args,
    this.argsVerduras,
    required this.delate,
    this.size = 25.0,
    this.isList = false,
    this.nameArgVerduras = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: AppTheme.primary.withOpacity(0.8),
      child: Column(
        children: [
          ListTile(
            title: Center(
                child: Text(
              isList ? nameArgVerduras : argsVerduras!.nombre,
              style: const TextStyle(fontSize: 18),
            )),
            subtitle: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: sizeW + 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Fecha Ingreso: ' + args.fechaIngreso.toString(),
                              style: TextStyle(fontSize: isList ? 18 : 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Fecha recordatorio: ' + args.fechaCaducidad.toString(),
                              style: TextStyle(fontSize: isList ? 18 : 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Cantidad: ' + args.cantidad.toString() + ' KG',
                              style: TextStyle(fontSize: isList ? 18 : 14),
                            ),
                          ],
                        ),
                        if (isList)
                          Column(
                            children: [
                              const SizedBox(
                                width: 0,
                              ),
                              IconButton(
                                  onPressed: delate,
                                  alignment: Alignment.centerRight,
                                  icon: const Icon(
                                    Icons.check_box_outlined,
                                    size: 40,
                                  ))
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
