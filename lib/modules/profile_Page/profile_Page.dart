import 'package:expensifly/modules/auth_modules/logics/auth_logics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../themes/themes.dart';

/// Profile Screen displayed to show user information and provide logout functionality.
class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
  });

  final box = GetStorage();
  final AuthLogic _authLogics = SyncEaseLogic.reg(AuthLogic());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            _authLogics.currentUser.userName,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColorBk),
          ),
          Text(
            _authLogics.currentUser.phoneNo,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: textTwo),
          ),
        ],
      ),
      alignment: AlignmentDirectional.bottomCenter,
      icon: const CircleAvatar(
        backgroundColor: Colors.black26,
        maxRadius: 25,
        child: Icon(
          Icons.person,
          size: 30,
          color: textColorBk,
        ),
      ),
      content: ElevatedButton(
          onPressed: () {
            _authLogics.logout(context);
          },
          child: const Text(
            "Sign Out",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColorBk),
          )),
      scrollable: true,
    );
  }
}
