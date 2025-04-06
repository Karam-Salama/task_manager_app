// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_list_app/modules/home/home_screen.dart';

import '../../core/functions/navigation.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    super.initState();
    delayedNavigate(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Image.asset(
          width: 213,
          height: 238,
          Assets.assetsLogo,
        ),
      ),
    );
  }

  void delayedNavigate(String routeName) {
    Future.delayed(const Duration(seconds: 2), () {
      customReplacementNavigate(context, routeName);
    });
  }
}
