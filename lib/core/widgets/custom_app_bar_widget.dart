import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/app_text_styles.dart';
import 'package:todo_list_app/modules/add_item/ui/screens/add_item_screen.dart';

import '../../modules/add_item/ui/cubit/tasks_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showActions;
  final bool showLeadingIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showActions = true,
    this.showLeadingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyle.pacifico700style23Black),
      toolbarHeight: 80,
      automaticallyImplyLeading: showLeadingIcon,
      elevation: 0,
      actions: showActions
          ? [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        context.read<TasksCubit>().clearControllers();
                        return const AddItemScreen();
                      },
                    ),
                  );
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
