import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../../component/my_switch_button.dart';
import '../../../component/squareTile.dart';
import '../../../themes/themes.dart';
import '../logics/auth_logics.dart';
import 'registration_page.dart'; // Assuming this is a valid import for the RegistrationPage

/// LoginPage Widget is responsible for handling user authentication and login.
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthLogic authLogic = SyncEaseLogic.reg(AuthLogic());
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Ease<bool> _passwordObscure = Ease(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Icon(
                    Icons.android,
                    size: 50,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Hello Again!",
                    style: TextStyle(fontSize: 38, fontFamily: 'BebasNeue'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome back, you've \n been missed!",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: textColor),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: userNameController,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            // Limits the input to 10 characters
                          ],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: "User Name",
                            suffixIcon: const Icon(Icons.person),
                            suffixIconColor: Theme.of(context).primaryColor,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: textColor),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: EaseBuilder(
                          ease: _passwordObscure,
                          builder: (BuildContext context, value) {
                            return TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                // Limits the input to 10 characters
                              ],
                              obscureText: _passwordObscure.value,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _passwordObscure.value =
                                        !_passwordObscure.value;
                                    // Toggle the visibility
                                  },
                                  child: Icon(
                                    _passwordObscure.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                suffixIconColor: Theme.of(context).primaryColor,
                                border: InputBorder.none,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: textColorBk,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MySwitchButton(
                      containerHeight: 53,
                      containerDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: textColorBk,
                      ),
                      title: "Sign In",
                      titleColor: textColor,
                      onPressed: () {
                        authLogic.login(
                          userName: userNameController.text,
                          password: passwordController.text,
                        );
                      },
                      mainAxisAlignments: MainAxisAlignment.spaceBetween,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: textColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: 'assets/images/auth/google-icon.png',
                      ),
                      SizedBox(width: 20),
                      SquareTile(
                        imagePath: 'assets/images/auth/facebook.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not a member?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                          child: Text(
                            " Register now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
