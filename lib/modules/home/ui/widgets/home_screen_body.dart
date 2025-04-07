import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/add_item/ui/cubit/tasks_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../add_item/ui/cubit/tasks_cubit.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TasksCubit, TasksStates>(
        listener: (context, state) {
          if (state is DisplayTasksSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tasks loaded successfully!'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is DisplayTasksErrorState) {
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
            return const Center(child: CircularProgressIndicator());
          } else if (state is DisplayTasksSuccessState) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(task['description']),
                );
              },
            );
          } else if (state is DisplayTasksErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No tasks available.'));
          }
        },
      ),
    );
  }
}
