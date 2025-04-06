import 'package:flutter/material.dart';
import 'package:todo_list_app/core/utils/app_text_styles.dart';
import 'package:todo_list_app/modules/add_item/ui/screens/add_item_screen.dart';

import '../../../core/functions/navigation.dart';

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
      toolbarHeight: 100,
      automaticallyImplyLeading: showLeadingIcon,
      actions: showActions
          ? [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 30),
                onPressed: () {
                  customNavigate(context, AddItemScreen.routeName);
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
