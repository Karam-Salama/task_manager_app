import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../cubit/tasks_cubit.dart';
import 'custom_adding_item_form_widget.dart';

class AddItemScreenBody extends StatelessWidget {
  const AddItemScreenBody({super.key, this.task});
  final Map<String, dynamic>? task;

  @override
  Widget build(BuildContext context) {
    final tasksCubit = BlocProvider.of<TasksCubit>(context);

    if (task != null) {
      tasksCubit.titleController.text = task!['title'];
      tasksCubit.descriptionController.text = task!['description'];
      tasksCubit.dateController.text = task!['date'];
      tasksCubit.timeController.text = task!['time'];
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: task == null ? AppStrings.addTask : AppStrings.editTask,
        showActions: false,
        showLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: SingleChildScrollView(
          child: CustomAddingItemForm(
            isEditing: task != null,
            taskId: task?['id'],
          ),
        ),
      ),
    );
  }
}
