// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/utils/app_strings.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../add_item/ui/cubit/tasks_cubit.dart';
import '../../../add_item/ui/cubit/tasks_state.dart';
import '../../../add_item/ui/screens/add_item_screen.dart';

class CustomTaskItemWidget extends StatelessWidget {
  const CustomTaskItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.id,
  });
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    TasksCubit tasksCubit = BlocProvider.of<TasksCubit>(context);
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {
        if (state is DeleteTaskSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task deleted successfully!'),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is DeleteTaskErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.pacifico700style23Black.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        final dateFormat = DateFormat('MM/dd/yyyy');
                        final timeFormat = DateFormat('h:mm a');

                        final parsedDate = dateFormat.parse(date);
                        final parsedTime = timeFormat.parse(time);

                        final scheduledTime = DateTime(
                          parsedDate.year,
                          parsedDate.month,
                          parsedDate.day,
                          parsedTime.hour,
                          parsedTime.minute,
                        );

                        if (scheduledTime.isBefore(DateTime.now())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Cannot schedule notification for past time',
                                style: AppTextStyle.pacifico700style23Black
                                    .copyWith(
                                  color: AppColors.backgroundColor,
                                  fontSize: 14,
                                ),
                              ),
                              backgroundColor: AppColors.redColor,
                            ),
                          );
                          return;
                        }

                        await NotificationService.scheduleTodoNotification(
                          id: id,
                          title: 'Reminder: $title',
                          description: description,
                          scheduledTime: scheduledTime,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Notification scheduled Successfully at ${timeFormat.format(scheduledTime)}',
                              style:
                                  AppTextStyle.pacifico700style23Black.copyWith(
                                color: AppColors.backgroundColor,
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Error Scheduling Notification: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyle.pacifico700style23Black.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: AppTextStyle.pacifico700style23Black.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    time,
                    style: AppTextStyle.pacifico700style23Black.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                color: AppColors.primaryColor,
                thickness: 1,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      tasksCubit.titleController.text = title;
                      tasksCubit.descriptionController.text = description;
                      tasksCubit.dateController.text = date;
                      tasksCubit.timeController.text = time;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                            task: {
                              'id': id,
                              'title': title,
                              'description': description,
                              'date': date,
                              'time': time,
                            },
                          ),
                        ),
                      ).then((_) {
                        tasksCubit.loadTasks();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      elevation: WidgetStateProperty.all<double>(10),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      AppStrings.edit,
                      style: AppTextStyle.pacifico700style23Black.copyWith(
                        color: AppColors.backgroundColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          message: AppStrings.deleteTask,
                          icon: Icons.delete,
                          textButton: AppStrings.delete,
                          onpressed: () {
                            Navigator.of(context).pop();
                            tasksCubit.deleteTask(id);
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        AppColors.redColor,
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      elevation: WidgetStateProperty.all<double>(10),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      AppStrings.delete,
                      style: AppTextStyle.pacifico700style23Black.copyWith(
                        color: AppColors.backgroundColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
