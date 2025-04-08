import 'package:flutter/material.dart';
import '../widgets/add_item_screen_body.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key, this.task});
  static const String routeName = '/add-item';
  final Map<String, dynamic>? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddItemScreenBody(task: task),
    );
  }
}
