import 'package:app_ihm/Providers/db_provider.dart';
import 'package:app_ihm/Providers/historics_list_provider.dart';
import 'package:app_ihm/screens/list_metrics.dart';
import 'package:app_ihm/services/notification_api.dart';
import 'Providers/vegetables_list_provider.dart';
import 'package:app_ihm/Theme/app_theme.dart';
import 'package:app_ihm/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await NotificationService().initializeApp();
  //NotificationService().showNotification(1, 'Prueba', 'Esto es una descripcion de prueba');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    ListenNotifications();
    onBgNotif();
  }

  void ListenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context)
      .push(MaterialPageRoute(builder: ((context) => const ListMetricsScreen())));

  void onBgNotif() async {
    final historics = await DBProvider.db.getUltimateHistoricos();
    final now = DateTime.now();
    String day = now.day < 10 ? '0' + now.day.toString() : now.day.toString();
    String month = now.month < 10 ? '0' + now.month.toString() : now.month.toString();
    String formatDate = day + '/' + month + '/' + now.year.toString();
    final h = historics.map((e) => e.fechaCaducidad == formatDate);
    if (h.contains(true)) {
      NotificationApi.showNotification(
        title: 'REFRINTELLIGENCE',
        body: 'Recordatorio: Tienes un producto que está por caducar.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoricsListProvider()),
        ChangeNotifierProvider(create: (_) => VegetablesListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RefrIntelligence',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getAppRoutes(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.ligthTheme,
      ),
    );
  }
}
