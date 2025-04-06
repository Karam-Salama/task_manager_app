import 'package:flutter_bloc/flutter_bloc.dart';

import 'display_tasks_state.dart';

class DisplayTasksCubit extends Cubit<DisplayTasksState> {
  DisplayTasksCubit() : super(DisplayTasksInitialState());
}
