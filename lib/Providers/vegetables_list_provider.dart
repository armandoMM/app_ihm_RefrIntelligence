import 'package:app_ihm/Providers/db_provider.dart';
import 'package:app_ihm/models/models.dart';
import 'package:flutter/material.dart';

class VegetablesListProvider extends ChangeNotifier {
  List<ArgsVerduras> totalArgs = [];

  cargarVegetables() async {
    final args = await DBProvider.db.getAllVerduras();
    totalArgs = [...args];
    notifyListeners();
  }
}
