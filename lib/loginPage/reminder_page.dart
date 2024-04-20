import 'package:flutter/material.dart';
import '../components/theme.dart';

class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Remind Me",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
            fontFamily: 'Oswald'),
      )),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Set up reminders here
          },
          child: Text(
            "Set Reminder",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
                fontFamily: 'Oswald'),
          ),
        ),
      ),
    );
  }
}
