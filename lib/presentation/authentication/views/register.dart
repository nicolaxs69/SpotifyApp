import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          width: 108,
          height: 33,
          AppVectors.logo,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          _registerText(),
          const SizedBox(height: 30),
          _fullNameField()
        ],
      ),
    );
  }
}

Widget _registerText() {
  return const Text(
    "Register",
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}

Widget _fullNameField() {
  return const TextField();
}
