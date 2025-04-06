import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/add_item/ui/cubit/add_item_cubit.dart';

import '../../../../core/functions/validation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../cubit/add_item_state.dart';
import 'cutom_text_form_field_widget_.dart';

class CustomAddingItemForm extends StatefulWidget {
  const CustomAddingItemForm({super.key});

  @override
  State<CustomAddingItemForm> createState() => _CustomAddingItemFormState();
}

class _CustomAddingItemFormState extends State<CustomAddingItemForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemCubit, AddItemState>(
      listener: (context, state) {},
      builder: (context, state) {
        AddItemCubit addItemCubit = BlocProvider.of<AddItemCubit>(context);
        return Form(
          key: addItemCubit.addItemFormKey,
          autovalidateMode: addItemCubit.addItemAutoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: AppStrings.taskTitle,
                keyboardType: TextInputType.text,
                onChanged: (title) {},
                validator: Validation.validateTaskTitle,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: AppStrings.taskDescription,
                keyboardType: TextInputType.text,
                maxLines: 3,
                onChanged: (description) {},
                validator: Validation.validateTaskDescription,
              ),
              const SizedBox(height: 33),
              state is AddItemLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      text: AppStrings.addTask,
                      mainAxisAlignment: MainAxisAlignment.center,
                      style: AppTextStyle.pacifico700style23Black.copyWith(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        if (addItemCubit.addItemFormKey.currentState!
                            .validate()) {
                          addItemCubit.addItemFormKey.currentState!.save();
                          // addItemCubit.addItemToFirebase(
                          //   context: context,
                          //   title: addItemCubit.title,
                          //   description: addItemCubit.description,
                          // );
                        } else {
                          setState(() {
                            addItemCubit.addItemAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}
