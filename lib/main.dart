import 'package:expensifly/modules/splash%20_modules/splash_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sync_ease/sync_ease.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCscWFwzYh0JxNvLI6v4dcGoflPFNt_sLI',
          appId: '1:268120911231:android:06e9ff8cf130b9cb80be4a',
          messagingSenderId: '268120911231',
          projectId: 'expensifly-13ea1'));

  await GetStorage.init();
  // Register background message handler

  runApp(SyncEaseApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily:'Roboto' ,
        primaryColor: const Color(0xff47b0ac),
        secondaryHeaderColor:const Color(0xfff9f9f9)),
    home: const SplashPage(),
  ));
}
