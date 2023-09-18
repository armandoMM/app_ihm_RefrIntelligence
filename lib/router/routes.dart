import 'package:flutter/material.dart';
import 'package:app_ihm/models/models.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'Home';
  static const detailMetricsRoute = 'DetailMetrics';
  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'Metricas',
        name: 'Metricas',
        screen: const MetricasViewScreen(),
        icon: Icons.file_open_outlined),
    MenuOption(
        route: 'Detalle metricas',
        name: 'Detalle metricas',
        screen: const DetailMetricsScreen(),
        icon: Icons.file_open_outlined),
    MenuOption(
        route: 'Lista metricas',
        name: 'Lista metricas',
        screen: const ListMetricsScreen(),
        icon: Icons.list_rounded),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (var option in menuOptions) {
      appRoutes.addAll({option.name: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }
}
