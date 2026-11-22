import 'package:flutter/material.dart';
import 'modules/home/page/home_page.dart';
import 'modules/history/page/history_page.dart';
import 'modules/initial/page/initial_page.dart';
import 'routes/app_routes.dart';
import 'shared/colors/app_colors.dart';

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FastLocation', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA), useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())),
    initialRoute: AppRoutes.initial,
    routes: {
      AppRoutes.initial: (_) => const InitialPage(),
      AppRoutes.home: (_) => const HomePage(),
      AppRoutes.history: (_) => const HistoryPage(),
    },
  );
}
