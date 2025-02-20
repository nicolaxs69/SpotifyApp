import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';

class RegisterLoginFooter extends StatelessWidget {
  const RegisterLoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppVectors.googleLogo,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 60),
            SvgPicture.asset(
              AppVectors.appleLogo,
              width: 40,
              height: 40,
            ),
          ],
        ),
        const SizedBox(height: 40),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
            children: [
              TextSpan(
                  text: "Do You Have An Account? ",
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              const TextSpan(
                text: "Sign In",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
