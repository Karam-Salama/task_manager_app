// validation.dart

class Validation {
  static String? validateTaskTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a task title';
    }
    return null;
  }

  static String? validateTaskDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a task description';
    }
    return null;
  }

  static String? validateTaskDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a task date';
    }
    return null;
  }

  static String? validateTaskTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a task time';
    }
    return null;
  }
}
