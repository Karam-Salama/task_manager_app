import 'package:flutter/material.dart';
import '../widgets/add_item_screen_body.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});
  static const String routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddItemScreenBody(),
    );
  }
}
