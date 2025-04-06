import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../cubit/display_tasks_cubit.dart';
import '../widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisplayTasksCubit>(
      create: (context) => DisplayTasksCubit(),
      child: const Scaffold(
        appBar: CustomAppBar(
          title: 'All Tasks',
          showActions: true,
        ),
        body: HomeScreenBody(),
      ),
    );
  }
}
