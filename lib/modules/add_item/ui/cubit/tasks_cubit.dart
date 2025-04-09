// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/notification_service.dart';
import '../../data/database_helper.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksStates> {
  TasksCubit() : super(AddItemInitialState());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  GlobalKey<FormState> addItemFormKey = GlobalKey<FormState>();
  AutovalidateMode addItemAutoValidateMode = AutovalidateMode.disabled;

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.parse('2030-01-01'),
    );
    if (pickedDate != null) {
      dateController.text = DateFormat.yMd().format(pickedDate);
    }
  }

  void selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      timeController.text = pickedTime.format(context);
    }
  }

  DateTime _parseTaskDateTime(String dateStr, String timeStr) {
    final dateFormat = DateFormat('MM/dd/yyyy');
    final timeFormat = DateFormat('h:mm a');

    final date = dateFormat.parse(dateStr);
    final time = timeFormat.parse(timeStr);

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void addItemToDatabase(BuildContext context, String title, String description,
      String date, String time) async {
    try {
      final task = {
        'title': title,
        'description': description,
        'date': date,
        'time': time,
      };
      final id = await DatabaseHelper().insertTask(task);
      emit(AddItemSuccessState());

      final scheduledTime = _parseTaskDateTime(date, time);
      if (scheduledTime.isAfter(DateTime.now())) {
        await NotificationService.scheduleTodoNotification(
          id: id,
          title: 'Reminder: $title',
          description: description,
          scheduledTime: scheduledTime,
        );
      }
    } catch (e) {
      emit(AddItemErrorState(e.toString()));
    }
  }

  Future<void> loadTasks() async {
    try {
      emit(DisplayTasksLoadingState());
      final tasks = await DatabaseHelper().getTasks();
      emit(DisplayTasksSuccessState(tasks: tasks));
    } catch (e) {
      emit(DisplayTasksErrorState(e.toString()));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await DatabaseHelper().deleteTask(id);
      await NotificationService.cancelNotification(id);
      emit(DisplayTasksLoadingState());
      await loadTasks();
    } catch (e) {
      emit(DisplayTasksErrorState(e.toString()));
    }
  }

  void updateTaskInDatabase(
    BuildContext context,
    int id,
    String title,
    String description,
    String date,
    String time,
  ) async {
    try {
      final task = {
        'title': title,
        'description': description,
        'date': date,
        'time': time,
      };
      await DatabaseHelper().updateTask(task, id);
      emit(AddItemSuccessState());

      // إلغاء الإشعار القديم وإنشاء جديد
      await NotificationService.cancelNotification(id);
      final scheduledTime = _parseTaskDateTime(date, time);
      if (scheduledTime.isAfter(DateTime.now())) {
        await NotificationService.scheduleTodoNotification(
          id: id,
          title: 'Updated: $title',
          description: description,
          scheduledTime: scheduledTime,
        );
      }
    } catch (e) {
      emit(AddItemErrorState(e.toString()));
    }
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
  }
}
