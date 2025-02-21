import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/common/widgets/button/basic_button.dart';
import 'package:refresh_flutter/common/widgets/or_divider.dart';
import 'package:refresh_flutter/common/widgets/register_login_footer.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/data/models/auth/create_user_request.dart';
import 'package:refresh_flutter/domain/usecases/authentication/signup.dart';
import 'package:refresh_flutter/presentation/home/views/home.dart';
import 'package:refresh_flutter/service_locator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool passwordVisible = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
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
              BasicButton(
                  onPressed: () async {
                    var result = await serviceLocator<SignupUseCase>().call(
                      CreateUserRequest(
                        fullName: _fullNameController.text.toString(),
                        email: _emailController.text.toString(),
                        password: _passwordController.text.toString(),
                      ),
                    );
                    result.fold(
                      (ifLeft) {
                        var snackbar = SnackBar(content: Text(ifLeft));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (ifRight) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeView()),
                            (route) => false);
                      },
                    );
                  },
                  title: "Create Account"),
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
      controller: _fullNameController,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: "Enter Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(
      BuildContext context, bool passwordVisible, VoidCallback togglePassword) {
    return TextField(
      controller: _passwordController,
      obscureText: !passwordVisible,
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
