import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitialState());

  GlobalKey<FormState> addItemFormKey = GlobalKey<FormState>();
  AutovalidateMode addItemAutoValidateMode = AutovalidateMode.disabled;
}
