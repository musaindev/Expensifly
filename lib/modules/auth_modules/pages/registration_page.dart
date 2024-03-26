import 'package:expensifly/modules/auth_modules/logics/auth_logics.dart';
import 'package:expensifly/modules/auth_modules/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../../component/my_switch_button.dart';
import '../../../component/squareTile.dart';
import '../../../themes/themes.dart';

/// A widget for the registration page.
class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthLogic _authLogic = SyncEaseLogic.reg(AuthLogic());

  final Ease<bool> _passwordObscure = Ease(false);
  final Ease<bool> _confirmPasswordObscure = Ease(false);

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
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 53,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Let\'s create an account for you!",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
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
                          controller: phoneNoController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            // Limits the input to 10 characters
                          ],
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Phone No",
                            suffixIcon: const Icon(Icons.phone_android_sharp),
                            suffixIconColor: Theme.of(context).primaryColor,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                              textInputAction: TextInputAction.next,
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
                  const SizedBox(
                    height: 10,
                  ),
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
                          ease: _confirmPasswordObscure,
                          builder: (BuildContext context, value) {
                            return TextFormField(
                              obscureText: _confirmPasswordObscure.value,
                              controller: confirmPasswordController,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                // Limits the input to 10 characters
                              ],
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _confirmPasswordObscure.value =
                                        !_confirmPasswordObscure.value;
                                  },
                                  child: Icon(
                                    _confirmPasswordObscure.value
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
                      title: "Sign Up",
                      titleColor: textColor,
                      onPressed: () {
                        _authLogic.register(
                          userName: userNameController.text,
                          phoneNo: phoneNoController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                          imagePath: 'assets/images/auth/google-icon.png'),
                      SizedBox(
                        width: 20,
                      ),
                      SquareTile(imagePath: 'assets/images/auth/facebook.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            to(LoginPage());
                          },
                          child: Text(
                            "Login now",
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
