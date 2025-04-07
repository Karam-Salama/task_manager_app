abstract class TasksStates {}

class AddItemInitialState extends TasksStates {}

class AddItemLoadingState extends TasksStates {}

class AddItemSuccessState extends TasksStates {}

class AddItemErrorState extends TasksStates {
  final String errorMessage;

  AddItemErrorState(this.errorMessage);
}

class DisplayTasksInitialState extends TasksStates {}

class DisplayTasksLoadingState extends TasksStates {}

class DisplayTasksSuccessState extends TasksStates {
  List<Map<String, dynamic>> tasks;
  DisplayTasksSuccessState({required this.tasks});
}

class DisplayTasksErrorState extends TasksStates {
  final String error;

  DisplayTasksErrorState(this.error);
}
