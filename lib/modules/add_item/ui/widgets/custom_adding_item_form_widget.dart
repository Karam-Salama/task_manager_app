import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/add_item/ui/cubit/tasks_cubit.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../cubit/tasks_state.dart';
import 'cutom_text_form_field_widget_.dart';

class CustomAddingItemForm extends StatefulWidget {
  const CustomAddingItemForm({
    super.key,
    this.isEditing = false,
    this.taskId,
  });

  final bool isEditing;
  final int? taskId;

  @override
  State<CustomAddingItemForm> createState() => _CustomAddingItemFormState();
}

class _CustomAddingItemFormState extends State<CustomAddingItemForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {
        if (state is AddItemSuccessState) {
          context.read<TasksCubit>().loadTasks();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.isEditing
                  ? "Updated Successfully"
                  : "Added Successfully"),
              backgroundColor: AppColors.primaryColor,
            ),
          );
          Navigator.pop(context);
        } else if (state is AddItemErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  widget.isEditing ? "Can't Update Item" : "Can't Add Item"),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
      },
      builder: (context, state) {
        TasksCubit taskCubit = BlocProvider.of<TasksCubit>(context);
        return Form(
          key: taskCubit.addItemFormKey,
          autovalidateMode: taskCubit.addItemAutoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                controller: taskCubit.titleController,
                hintText: AppStrings.taskTitle,
                keyboardType: TextInputType.text,
                validator: Validation.validateTaskTitle,
                onChanged: (title) {
                  taskCubit.titleController.text = title;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: taskCubit.descriptionController,
                hintText: AppStrings.taskDescription,
                keyboardType: TextInputType.text,
                maxLines: 3,
                validator: Validation.validateTaskDescription,
                onChanged: (description) {
                  taskCubit.descriptionController.text = description;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: taskCubit.dateController,
                hintText: AppStrings.taskDate,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                validator: Validation.validateTaskDate,
                onTap: () {
                  taskCubit.selectDate(context);
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: taskCubit.timeController,
                hintText: AppStrings.taskTime,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                validator: Validation.validateTaskTime,
                onTap: () {
                  taskCubit.selectTime(context);
                },
              ),
              const SizedBox(height: 33),
              state is AddItemLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      text: widget.isEditing
                          ? AppStrings.updateTask
                          : AppStrings.addTask,
                      mainAxisAlignment: MainAxisAlignment.center,
                      style: AppTextStyle.pacifico700style23Black.copyWith(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        if (taskCubit.addItemFormKey.currentState!.validate()) {
                          taskCubit.addItemFormKey.currentState!.save();
                          if (widget.isEditing && widget.taskId != null) {
                            taskCubit.updateTaskInDatabase(
                              context,
                              widget.taskId!,
                              taskCubit.titleController.text,
                              taskCubit.descriptionController.text,
                              taskCubit.dateController.text,
                              taskCubit.timeController.text,
                            );
                          } else {
                            taskCubit.addItemToDatabase(
                              context,
                              taskCubit.titleController.text,
                              taskCubit.descriptionController.text,
                              taskCubit.dateController.text,
                              taskCubit.timeController.text,
                            );
                          }
                        } else {
                          setState(() {
                            taskCubit.addItemAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
