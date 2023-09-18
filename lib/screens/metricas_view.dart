import 'package:app_ihm/Providers/vegetables_list_provider.dart';
import 'package:app_ihm/models/models.dart';
import 'package:app_ihm/Theme/app_theme.dart';
import 'package:app_ihm/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetricasViewScreen extends StatefulWidget {
  const MetricasViewScreen({Key? key}) : super(key: key);

  @override
  State<MetricasViewScreen> createState() => _MetricasViewScreenState();
}

class _MetricasViewScreenState extends State<MetricasViewScreen> {
  final menuOptions = AppRoutes.menuOptions;
  bool isLoading = false;
  String fechaIngreso = '', fechaCaducidad = '', cantidad = '';
  String nombre = 'Tomate';
  late int idVerdura;

  void callDatePickerIni(BuildContext context) async {
    try {
      var initialDate = DateTime.now();
      var firstDate = DateTime.now();
      var lastDate = DateTime(initialDate.year, initialDate.month + 1, initialDate.day);
      var newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                  primary: AppTheme.secondary, onSurface: AppTheme.textSecondary),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: AppTheme.textSecondary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (newDate == null) return;
      String day = newDate.day < 10 ? '0' + newDate.day.toString() : newDate.day.toString();
      String month = newDate.month < 10 ? '0' + newDate.month.toString() : newDate.month.toString();
      String formatDate = day + '/' + month + '/' + newDate.year.toString();
      setState(() {
        fechaIngreso = formatDate;
      });
    } catch (e) {
      //print(e);
    }
  }

  void callDatePickerCad(BuildContext context) async {
    try {
      var initialDate = DateTime.now();
      var firstDate = DateTime.now();
      var lastDate = DateTime(initialDate.year, initialDate.month + 1, initialDate.day);
      var newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                  primary: AppTheme.secondary, onSurface: AppTheme.textSecondary),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: AppTheme.textSecondary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (newDate == null) return;
      String day = newDate.day < 10 ? '0' + newDate.day.toString() : newDate.day.toString();
      String month = newDate.month < 10 ? '0' + newDate.month.toString() : newDate.month.toString();
      String formatDate = day + '/' + month + '/' + newDate.year.toString();
      setState(() {
        fechaCaducidad = formatDate;
      });
    } catch (e) {
      //print(e);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Campos vacíos'),
      content: const Text('Asegurate de llenar todos los campos.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    final vegetablesProvider = Provider.of<VegetablesListProvider>(context);
    final vegetables = vegetablesProvider.totalArgs;
    final veg = vegetables.map((e) => e.nombre).toList();
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Nuevo recordatorio',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 35),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(Icons.notifications, size: 100, color: AppTheme.secondary),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Producto',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<String>(
                        value: nombre,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: AppTheme.textSecondary,
                        ),
                        elevation: 10,
                        style: const TextStyle(color: AppTheme.secondary),
                        underline: Container(
                          height: 2,
                          width: 20,
                          color: AppTheme.secondary,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            nombre = newValue!;
                          });
                        },
                        items: veg.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 23),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Cantidad',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        style: const TextStyle(color: AppTheme.textSecondary),
                        textAlign: TextAlign.center,
                        initialValue: cantidad,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Ingresa la cantidad',
                          hintStyle: TextStyle(color: AppTheme.textSecondary),
                          suffix: Text(
                            'KG',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String value) => cantidad = value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Fecha de ingreso',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: sizeW / 2 - 120),
                        ElevatedButton(
                          child: SizedBox(
                              width: 200,
                              child: Center(
                                  child:
                                      Text(fechaIngreso == '' ? 'Seleccione...' : fechaIngreso))),
                          onPressed: () async {
                            callDatePickerIni(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.calendar_month_outlined, color: AppTheme.textSecondary),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Fecha de recordatorio: ',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: sizeW / 2 - 120),
                        ElevatedButton(
                          child: SizedBox(
                              width: 200,
                              child: Center(
                                  child: Text(
                                      fechaCaducidad == '' ? 'Seleccione...' : fechaCaducidad))),
                          onPressed: () async {
                            callDatePickerCad(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.calendar_month_outlined, color: AppTheme.textSecondary)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.secondary,
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 40,
            ),
            onPressed: () async {
              if (cantidad.isEmpty && fechaCaducidad.isEmpty && fechaIngreso.isEmpty) {
                showAlertDialog(context);
                return;
              }
              if (cantidad == '' || fechaCaducidad == '' || fechaIngreso == '') {
                showAlertDialog(context);
                return;
              }
              final v = vegetables.firstWhere((e) => e.nombre == nombre);
              idVerdura = v.idVerdura;
              nombre = v.nombre;
              Navigator.pushNamed(context, menuOptions[1].route,
                  arguments: Arguments(
                      fechaIngreso: fechaIngreso,
                      fechaCaducidad: fechaCaducidad,
                      cantidad: cantidad,
                      idVerdura: idVerdura));
            },
          ),
        ),
      ),
    );
  }
}
