import 'package:app_ihm/Providers/historics_list_provider.dart';
import 'package:app_ihm/Providers/vegetables_list_provider.dart';
import 'package:app_ihm/Theme/app_theme.dart';
import 'package:app_ihm/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          const Center(
            child: Text(
              'RefrIntelligence',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 38),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Center(
            child: Image.asset('assets/logo_transparent.png'),
          ),
          const SizedBox(
            height: 1,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(
                  child: const SizedBox(
                      width: 300, child: Center(child: Text('Agregar recordatorio'))),
                  onPressed: () {
                    final vegetablesProvider =
                        Provider.of<VegetablesListProvider>(context, listen: false);
                    vegetablesProvider.cargarVegetables();
                    Navigator.pushNamed(context, menuOptions[0].route);
                  }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(
                  child: const SizedBox(
                      width: 300, child: Center(child: Text('Lista de recordatorios'))),
                  onPressed: () {
                    final historicsProvider =
                        Provider.of<HistoricsListProvider>(context, listen: false);
                    historicsProvider.cargarHistoricos();
                    final vegetablesProvider =
                        Provider.of<VegetablesListProvider>(context, listen: false);
                    vegetablesProvider.cargarVegetables();
                    Navigator.pushNamed(context, menuOptions[2].route);
                  }),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
