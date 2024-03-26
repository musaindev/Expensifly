import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensifly/data/models/user.dart';
import 'package:expensifly/modules/auth_modules/pages/login_page.dart';
import 'package:expensifly/modules/home_Page/pages/homePage.dart';
import 'package:expensifly/themes/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../../utils/firebase_const.dart';

/// Logic class for handling authentication-related operations.
class AuthLogic extends SyncEaseLogic {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _box = GetStorage();
  User? _currentUser;

  User get currentUser {
    return User.fromMap(_box.read("currentUser") ?? {});
  }

  /// Displays a snack bar with the provided [title].
  snackBar({
    required String title,
  }) {
    showSyncSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          const Icon(
            Icons.info,
            color: Colors.white70,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: Colors.red,
    ));
  }

  showLoading() {
    showSyncAlertBox(builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: switchBgColor,
        ),
      );
    });
  }

  /// Logs in a user with the provided [userName] and [password].
  ///
  /// If successful, navigates to the home page.
  login({
    required String userName,
    required String password,
  }) async {
    // Validate input fields
    if (userName.isEmpty) {
      snackBar(
        title: 'Please enter your username',
      );
    } else if (password.isEmpty) {
      snackBar(title: 'Please enter your password');
    } else {
      showLoading();
      QuerySnapshot<Map<String, dynamic>> userAlreadyExit = await _db
          .collection(FirebaseConst.usersCollection)
          .where("userName", isEqualTo: userName.toLowerCase().trim())
          .where("password", isEqualTo: password)
          .get();

      if (userAlreadyExit.docs.isEmpty) {
        snackBar(title: ' Check username and password');
        back();
      } else {
        _currentUser = User.fromMap(userAlreadyExit.docs.first.data());
        await _box.write("currentUser", _currentUser!.toMap());
        updateFcm();
        to(const HomePage());
        put();
      }
    }
  }

  /// Registers a new user with the provided [userName], [phoneNo], and [password].
  ///
  /// If successful, navigates to the home page.
  register(
      {required String userName,
      required String phoneNo,
      required String password,
      required String confirmPassword}) async {
    // Validate input fields
    if (userName.isEmpty) {
      return snackBar(title: 'Please enter your user name');
    } else if (phoneNo.isEmpty) {
      return snackBar(title: 'Please enter your phone number');
    } else if (password.isEmpty) {
      return snackBar(title: 'Please enter your password ');
    } else if (confirmPassword.isEmpty) {
      return snackBar(title: 'Please enter your confirmPassword ');
    } else if (password != confirmPassword) {
      return snackBar(title: 'Passwords do not match');
    } else {
      showLoading();
      // Check if the user already exists
      QuerySnapshot<Map<String, dynamic>> userIsAlreadyExist = await _db
          .collection(FirebaseConst.usersCollection)
          .where("userName", isEqualTo: userName)
          .get();


      // If user exists, show snack Bar
      if (userIsAlreadyExist.docs.isNotEmpty) {
        snackBar(title: 'The user already exists.');
      } else {
        // Create a new user
        User newUser = User(
          userName: userName.toLowerCase().replaceAll(" ", ""),
          phoneNo: phoneNo,
          password: password,
          fcmToken: "",
          userId: "",
        );

        DocumentReference<Map<String, dynamic>> addUser = await _db
            .collection(FirebaseConst.usersCollection)
            .add(newUser.toMap());
        await _db
            .collection(FirebaseConst.usersCollection)
            .doc(addUser.id)
            .update({'userId': addUser.id});
        var getUser = await addUser.get();
        _currentUser = User.fromMap(getUser.data()!);
        await _box.write("currentUser", _currentUser!.toMap());
        updateFcm();
        to(HomePage());
        put();
      }
    }
  }

  /// Updates the Firebase Cloud Messaging (FCM) token for the current user.
  Future<void> updateFcm() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await _db
          .collection(FirebaseConst.usersCollection)
          .doc(_currentUser!.userId)
          .update({'fcmToken': fcmToken});
    }
  }

  Future<void> logout(context) async {
    await _box.remove('currentUser');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
