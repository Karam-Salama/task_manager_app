import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/onGenerate_routes.dart';
import '../../core/utils/app_colors.dart';
import '../add_item/ui/cubit/tasks_cubit.dart';
import '../splash/screens/splash_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit()..loadTasks(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.backgroundColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
