import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travels/core/app_colors.dart';
import 'package:my_travels/core/primary_text.dart';

import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (control) {
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: changeTheme
                      ? scaffoldDarkBackground
                      : lightScaffoldBackground(context),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: changeTheme
                          ? scaffoldDarkBackground
                          : lightScaffoldBackground(context),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: PrimaryText(
                              'Email',
                              color: changeTheme ? lilyWhite : black,
                            ),
                          ),
                          TextFormField(
                            controller: control.emailController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: PrimaryText(
                              'Senha',
                              color: changeTheme ? lilyWhite : black,
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            controller: control.passwordController,
                            decoration: InputDecoration(
                              label: const Text('Senha'),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.visibility_rounded),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              control.login(control.email, control.password);
                            },
                            child: const Text('Sign In'),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () => control.navigateSignup(),
                            child: Text.rich(
                              TextSpan(
                                text: "Ainda não tem uma conta? ",
                                style: TextStyle(
                                  color: changeTheme ? lilyWhite : black,
                                  fontSize: 16,
                                ),
                                children: const [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: defaultIconColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
