import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/app_text_styles.dart';
import 'package:todo_list_app/modules/home/ui/cubit/display_tasks_cubit.dart';

import '../cubit/display_tasks_state.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DisplayTasksCubit, DisplayTasksState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Text(
              'Welcome to the Home Screen!',
              style: AppTextStyle.pacifico700style23Black,
            ),
          );
        },
      ),
    );
  }
}
