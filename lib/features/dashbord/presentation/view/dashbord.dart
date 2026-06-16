import 'package:flutter/material.dart';

class Dashbord extends StatelessWidget {
  const Dashbord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
                mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Center(
            child: Text(
              'DashBoard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
