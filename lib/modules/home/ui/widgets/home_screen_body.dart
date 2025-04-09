import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/add_item/ui/cubit/tasks_state.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../add_item/ui/cubit/tasks_cubit.dart';
import 'custom_task_item_widget.dart';
import 'task_item_shimmer_widget.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TasksCubit, TasksStates>(
        listener: (context, state) {
          if (state is DisplayTasksErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DisplayTasksLoadingState) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const TaskItemShimmer(),
            );
          } else if (state is DisplayTasksSuccessState) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text('No tasks available.'));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return CustomTaskItemWidget(
                  id: task['id'],
                  title: task['title'],
                  description: task['description'],
                  date: task['date'],
                  time: task['time'],
                );
              },
            );
          } else if (state is DisplayTasksErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(
              child: Text(
                'No tasks available.',
                style: AppTextStyle.pacifico700style23Black,
              ),
            );
          }
        },
      ),
    );
  }
}
