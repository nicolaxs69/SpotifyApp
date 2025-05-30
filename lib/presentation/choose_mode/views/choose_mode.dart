import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/widgets/button/basic_button.dart';
import 'package:refresh_flutter/core/configs/assets/app_images.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/presentation/authentication/views/signup.dart';
import 'package:refresh_flutter/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModeView extends StatelessWidget {
  const ChooseModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 69,
              horizontal: 30,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.chooseBg,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    AppVectors.logo,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Choose Mode',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ModeOption(
                      title: "Dark Mode",
                      svgAsset: AppVectors.moonLogo,
                      onTap: () {
                        context.read<ThemeCubit>().changeTheme(ThemeMode.dark);
                      },
                    ),
                    _ModeOption(
                      title: "Light Mode", 
                      svgAsset: AppVectors.sunLogo,
                      onTap: () {
                        context.read<ThemeCubit>().changeTheme(ThemeMode.light);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 37),
                BasicButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const SignupView()),
                    );
                  },
                  title: "Continue",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _ModeOption extends StatelessWidget {
  final String title;
  final String svgAsset;
  final VoidCallback onTap;

  const _ModeOption({
    required this.title,
    required this.svgAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 73,
                width: 73,
                decoration: BoxDecoration(
                  color: const Color(0xff30393C).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  svgAsset,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
