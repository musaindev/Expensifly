import 'package:expensifly/modules/home_Page/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sync_ease/sync_ease.dart';

import '../auth_modules/pages/login_page.dart';

/// Splash Page displayed when the app starts.
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  /// Handles navigation after a short delay.
  Future<void> navigator() async {

    await Future.delayed(const Duration(seconds: 2));
    final box = GetStorage();
    if (box.read("currentUser") == null) {
      to(LoginPage());
    } else {
      to(const HomePage());
    }
  }



  @override
  void initState() {
    navigator();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF06D28A),
                  ),
                  child: const Image(
                    image:
                        AssetImage('assets/images/flash_screen/expensify.png'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: Theme.of(context).primaryColor,
                  rightDotColor: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
