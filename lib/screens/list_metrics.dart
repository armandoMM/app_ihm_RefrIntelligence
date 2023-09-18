import 'package:app_ihm/Providers/historics_list_provider.dart';
import 'package:app_ihm/Providers/vegetables_list_provider.dart';
import 'package:app_ihm/models/models.dart';
import 'package:app_ihm/router/routes.dart';
import 'package:app_ihm/Providers/db_provider.dart';
import 'package:app_ihm/Theme/app_theme.dart';
import 'package:app_ihm/models/arguments.dart';
import 'package:app_ihm/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMetricsScreen extends StatefulWidget {
  const ListMetricsScreen({Key? key}) : super(key: key);

  @override
  State<ListMetricsScreen> createState() => _ListMetricsScreenState();
}

class _ListMetricsScreenState extends State<ListMetricsScreen> {
  // List<Arguments> totalArgs = [];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  Future fetchData() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;

    setState(() {});
    if (scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;
    // scrollController.animateTo(scrollController.position.pixels + 120,
    //     duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    fetchData();
  }

  Future<void> onDelete(int id) async {
    print(id);
    await DBProvider.db.deleteHistorico(id);
  }

  showAlertDialog(BuildContext context) async {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Eliminación'),
      content: const Text('Se eliminó correctamente el recordatorio.'),
      actions: [
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK')},
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
    final historicsProvider = Provider.of<HistoricsListProvider>(context);
    final vegetablesProvider = Provider.of<VegetablesListProvider>(context);
    final historics = historicsProvider.totalArgs;
    final vegetables = vegetablesProvider.totalArgs;
    List<Arguments> totalArgs = historicsProvider.totalArgs;
    List<ArgsVerduras> totalArgsVerduras = vegetablesProvider.totalArgs;
    List<int> ids = [];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('LISTA DE RECORDATORIOS'),
        ),
      ),
      body: Stack(
        children: [
          if (totalArgs.isEmpty)
            const Center(
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: Text(
                    'NO SE ENCONTRARON RECORDATORIOS',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
                  ))),
            ),
          if (totalArgs.isNotEmpty && totalArgsVerduras.isNotEmpty)
            RefreshIndicator(
              color: AppTheme.primary,
              onRefresh: onRefresh,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: historics.length,
                itemBuilder: (BuildContext context, int index) {
                  ids.add(historics[index].idVerdura);
                  return CustomCard(
                    args: historics[index],
                    //argsVerduras: vegetables[index],
                    size: 10,
                    isList: true,
                    nameArgVerduras: vegetables[ids.elementAt(index) - 1].nombre,
                    delate: () async {
                      await onDelete(historics[index].idHistorico!);
                      Navigator.pushNamed(context, AppRoutes.initialRoute);
                    },
                  );
                },
              ),
            ),
          if (isLoading)
            Positioned(bottom: 40, left: (size.width * 0.5 - 40), child: const _LoadingIcon()),
        ],
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      height: 60,
      width: 60,
      child: const CircularProgressIndicator(
        color: AppTheme.primary,
      ),
    );
  }
}
