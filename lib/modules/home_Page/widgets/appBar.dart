import 'package:expensifly/modules/home_Page/widgets/alert_Box.dart';
import 'package:expensifly/modules/profile_Page/profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../../component/my_icon_button.dart';
import '../../../themes/themes.dart';

/// A custom app bar widget for the home page.
class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Expensify",
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'BebasNeue',
              fontWeight: FontWeight.bold,
              color: buttonColor,
              letterSpacing: 3
            ),
          ),
          MyIconButton('assets/images/appBar/notification_icons.png', () {}),
          MyIconButton('assets/images/appBar/addButton.png', () {
            showSyncAlertBox(builder: (context) {
              return AlertBox();
            });
          }),
          IconButton(
            onPressed: () {
              showSyncAlertBox(builder: (context){
                return ProfileScreen();
              });
            },
            icon: CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
