import 'package:app_ihm/Providers/db_provider.dart';
import 'package:app_ihm/Providers/vegetables_list_provider.dart';
import 'package:app_ihm/Theme/app_theme.dart';
import 'package:app_ihm/models/models.dart';
import 'package:app_ihm/widgets/custom_card.dart';
import 'package:app_ihm/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailMetricsScreen extends StatelessWidget {
  const DetailMetricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    final vegetablesProvider = Provider.of<VegetablesListProvider>(context);
    final vegetables = vegetablesProvider.totalArgs;
    final ArgsVerduras argsVerduras = vegetables.firstWhere((e) => e.idVerdura == args.idVerdura);
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 150),
        children: [
          const Center(
            child: Text(
              'Recordatorio guardado: ',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 35),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.check_box_rounded, size: 100, color: AppTheme.secondary),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: sizeW,
            child: CustomCard(
              args: args,
              argsVerduras: argsVerduras,
              delate: () {},
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.secondary,
          child: const Icon(Icons.close),
          onPressed: () {
            DBProvider.db.newHistoricos(args);
            Navigator.pushNamed(context, AppRoutes.initialRoute);
          }),
    );
  }
}
