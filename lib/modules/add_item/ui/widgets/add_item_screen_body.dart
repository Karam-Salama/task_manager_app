import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar_widget.dart';
import 'custom_adding_item_form_widget.dart';

class AddItemScreenBody extends StatelessWidget {
  const AddItemScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Add Item',
        showActions: false,
        showLeadingIcon: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: SingleChildScrollView(child: CustomAddingItemForm()),
      ),
    );
  }
}
