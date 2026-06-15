import 'package:ecommerce_user_app/general/widgets/cw_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(20),
            Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Gap(50),
            CwTextFormfield(title: 'Name', hintText: 'Enter your name'),
            Gap(20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Update Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
