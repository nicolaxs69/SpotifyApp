import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/common/widgets/button/basic_button.dart';
import 'package:refresh_flutter/common/widgets/or_divider.dart';
import 'package:refresh_flutter/common/widgets/register_login_footer.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              _registerText(),
              const SizedBox(height: 15),
              _supportText(context),
              const SizedBox(height: 20),
              _fullNameField(context),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(
                context,
                passwordVisible,
                () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              const SizedBox(height: 40),
              BasicButton(onPressed: () {}, title: "Create Account"),
              const SizedBox(height: 40),
              const OrDivider(),
              const SizedBox(height: 40),
              const RegisterLoginFooter(),
            ],
          ),
        ),
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

Widget _supportText(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: context.isDarkMode
            ? Colors.white
            : Colors.black, // default color, adjust as needed
      ),
      children: const [
        TextSpan(text: "If You Need Any Support "),
        TextSpan(
          text: "Click Here",
          style: TextStyle(color: Colors.green),
        ),
      ],
    ),
  );
}

Widget _fullNameField(BuildContext context) {
  return TextField(
    decoration: const InputDecoration(
      hintText: "Full Name",
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _emailField(BuildContext context) {
  return TextField(
    decoration: const InputDecoration(
      hintText: "Enter Email",
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _passwordField(
    BuildContext context, bool passwordVisible, VoidCallback togglePassword) {
  return TextField(
    obscureText: passwordVisible,
    decoration: InputDecoration(
      hintText: "Password",
      suffixIcon: IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: togglePassword,
      ),
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}
