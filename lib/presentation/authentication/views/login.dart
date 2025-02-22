import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/common/widgets/button/basic_button.dart';
import 'package:refresh_flutter/common/widgets/or_divider.dart';
import 'package:refresh_flutter/common/widgets/register_login_footer.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/data/models/auth/sigin_user_request.dart';
import 'package:refresh_flutter/domain/usecases/authentication/signin.dart';
import 'package:refresh_flutter/presentation/home/views/home.dart';
import 'package:refresh_flutter/service_locator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              BasicButton(
                  onPressed: () async {
                       Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeView()),
                            (route) => false);
                    // var result = await serviceLocator<SigninUseCase>().call(
                    //   SignInUserRequest(
                    //     email: _emailController.text.toString(),
                    //     password: _passwordController.text.toString(),
                    //   ),
                    // );
                    // result.fold(
                    //   (ifLeft) {
                    //     var snackbar = SnackBar(content: Text(ifLeft));
                    //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    //   },
                    //   (ifRight) {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 const HomeView()),
                    //         (route) => false);
                    //   },
                    // );
                  },
                  title: "Sign In"),
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

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: "Enter Username Or Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(
      BuildContext context, bool passwordVisible, VoidCallback togglePassword) {
    return TextField(
      controller: _passwordController,
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
}

Widget _registerText() {
  return const Text(
    "Sign In",
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