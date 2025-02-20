import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/common/widgets/button/basic_button.dart';
import 'package:refresh_flutter/core/configs/assets/app_images.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/presentation/authentication/views/login.dart';
import 'package:refresh_flutter/presentation/authentication/views/register.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.patternTopLogo,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.patternBottomLogo,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-15, 15),
              child: Image.asset(
                AppImages.billieBg,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppVectors.logo,
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Text(
                    "Enjoy Listening To Music",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const Text(
                    "Spotify is a proprietary Swedish audio streaming and media services provider",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayFont,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _singUpButtons(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _singUpButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: BasicButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const RegisterView(),
                ),
              );
            },
            title: 'Register',
            height: 70,
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginView(),
                ),
              );
            },
            child: Text(
              "Sing in",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
