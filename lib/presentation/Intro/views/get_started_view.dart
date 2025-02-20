import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refresh_flutter/common/widgets/button/basic_button.dart';
import 'package:refresh_flutter/core/configs/assets/app_images.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/presentation/choose_mode/views/choose_mode.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

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
                  AppImages.introBg,
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
                  'Enjoy Listening To Music',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 21),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 37),
                BasicButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChooseModeView()),
                    );
                  },
                  title: "Get Started",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
