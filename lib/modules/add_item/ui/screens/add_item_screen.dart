import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_item_cubit.dart';
import '../widgets/add_item_screen_body.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});
  static const String routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddItemCubit>(
      create: (context) => AddItemCubit(),
      child: const Scaffold(
        body: AddItemScreenBody(),
      ),
    );
  }
}
