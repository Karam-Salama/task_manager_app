// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/add_item/ui/cubit/tasks_cubit.dart';
import '../../modules/add_item/ui/screens/add_item_screen.dart';
import '../../modules/home/ui/screens/home_screen.dart';
import '../../modules/splash/screens/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case AddItemScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<TasksCubit>(context),
          child: const AddItemScreen(),
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
