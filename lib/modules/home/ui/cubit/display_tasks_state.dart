abstract class DisplayTasksState {}

class DisplayTasksInitialState extends DisplayTasksState {}

class DisplayTasksLoadingState extends DisplayTasksState {}

class DisplayTasksSuccessState extends DisplayTasksState {}

class DisplayTasksErrorState extends DisplayTasksState {
  final String error;

  DisplayTasksErrorState(this.error);
}
