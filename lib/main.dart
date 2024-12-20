import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc_clean_app/core/utils/colors.dart';
import 'package:todo_bloc_clean_app/core/utils/di.dart';
import 'package:todo_bloc_clean_app/core/utils/navigation_service.dart';
import 'package:todo_bloc_clean_app/core/utils/routes.dart';
import 'package:todo_bloc_clean_app/features/authentication/data/models/user_model.dart';
import 'features/authentication/data/models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  await ServiceLocator.injectDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(AppColors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Finzy Todo App',
      //home: const AuthScreen(),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
