import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travels/presenter/auth/login_page.dart';

import '../../../core/app_colors.dart';
import '../../core/primary_text.dart';
import 'auth_controller.dart';
import 'widgets/custom_header.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (control) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: changeTheme
                      ? scaffoldDarkBackground
                      : lightScaffoldBackground(context),
                ),
                CustomHeader(
                    text: 'Sign Up',
                    onTap: () {
                      Get.offAll(() => const LoginPage());
                    }),
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
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
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
                              'Usuário',
                              color: changeTheme ? lilyWhite : black,
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            controller: control.nameControlller,
                            decoration: const InputDecoration(
                              label: Text('Usuário'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: PrimaryText(
                              'Email',
                              color: changeTheme ? lilyWhite : black,
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            controller: control.emailController,
                            decoration: const InputDecoration(
                              label: Text(
                                'Email',
                              ),
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
                            onPressed: () => control.register(
                                control.email, control.password),
                            child: const Text('Sign Up'),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => const LoginPage());
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Já tem uma conta? ",
                                style: TextStyle(
                                  color: changeTheme ? lilyWhite : black,
                                  fontSize: 16,
                                ),
                                children: const [
                                  TextSpan(
                                    text: "Sign in",
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
            );
          },
        ),
      ),
    );
  }
}
