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
  const CustomAddingItemForm({super.key});

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
            const SnackBar(
              content: Text("Added Successfully"),
              backgroundColor: AppColors.primaryColor,
            ),
          );

          Navigator.pop(context);
        } else if (state is AddItemErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Can't Add Item"),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
      },
      builder: (context, state) {
        TasksCubit addItemCubit = BlocProvider.of<TasksCubit>(context);
        return Form(
          key: addItemCubit.addItemFormKey,
          autovalidateMode: addItemCubit.addItemAutoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                controller: addItemCubit.titleController,
                hintText: AppStrings.taskTitle,
                keyboardType: TextInputType.text,
                validator: Validation.validateTaskTitle,
                onChanged: (title) {
                  addItemCubit.titleController.text = title;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addItemCubit.descriptionController,
                hintText: AppStrings.taskDescription,
                keyboardType: TextInputType.text,
                maxLines: 3,
                validator: Validation.validateTaskDescription,
                onChanged: (description) {
                  addItemCubit.descriptionController.text = description;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addItemCubit.dateController,
                hintText: AppStrings.taskDate,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                validator: Validation.validateTaskDate,
                onTap: () {
                  addItemCubit.selectDate(context);
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addItemCubit.timeController,
                hintText: AppStrings.taskTime,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                validator: Validation.validateTaskTime,
                onTap: () {
                  addItemCubit.selectTime(context);
                },
              ),
              const SizedBox(height: 33),
              state is AddItemLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      text: AppStrings.addTask,
                      mainAxisAlignment: MainAxisAlignment.center,
                      style: AppTextStyle.pacifico700style23Black.copyWith(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        if (addItemCubit.addItemFormKey.currentState!
                            .validate()) {
                          addItemCubit.addItemFormKey.currentState!.save();
                          addItemCubit.addItemToDatabase(
                            context,
                            addItemCubit.titleController.text,
                            addItemCubit.descriptionController.text,
                            addItemCubit.dateController.text,
                            addItemCubit.timeController.text,
                          );
                        } else {
                          setState(() {
                            addItemCubit.addItemAutoValidateMode =
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
