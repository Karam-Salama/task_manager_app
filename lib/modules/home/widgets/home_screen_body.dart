import 'package:flutter/material.dart';
import 'package:todo_list_app/core/utils/app_text_styles.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: AppTextStyle.pacifico700style23Black,
        ),
      ),
    );
  }
}
