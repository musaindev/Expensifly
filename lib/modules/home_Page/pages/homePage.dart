import 'package:flutter/material.dart';

import '../widgets/appBar.dart';
import '../widgets/listExpense.dart';

/// A stateless widget representing the home page of the application.
class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color to the secondary header color from the theme
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: const SafeArea(
        child: Column(
          children: [
            // Display the custom app bar widget
            Appbar(),
            // Expanded widget to fill the remaining space with the list of expenses
            Expanded(child: ListExpense()),
          ],
        ),
      ),
    );
  }
}
