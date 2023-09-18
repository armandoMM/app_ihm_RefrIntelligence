import 'package:app_ihm/Providers/db_provider.dart';
import 'package:app_ihm/models/models.dart';
import 'package:flutter/material.dart';

class HistoricsListProvider extends ChangeNotifier {
  List<Arguments> totalArgs = [];

  cargarHistoricos() async {
    final args = await DBProvider.db.getAllHistoricos();
    totalArgs = [...args];
    notifyListeners();
  }
}
