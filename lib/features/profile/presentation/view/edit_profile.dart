import 'package:ecommerce_user_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:ecommerce_user_app/features/dashbord/presentation/view/dashbord.dart';
import 'package:ecommerce_user_app/general/services/easy_navigation.dart';
import 'package:ecommerce_user_app/general/widgets/cw_text_formfield.dart';
import 'package:ecommerce_user_app/general/widgets/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Column(
              children: [
                Gap(20),
                Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(50),
                CwTextFormfield(
                  title: 'Name',
                  hintText: 'Enter your name',
                  controller: authProvider.nameCtl,
                ),
                Gap(20),
                Center(
                  child: ElevatedButton(
                    onPressed: authProvider.isUpdatingProfile
                        ? null
                        : () async {
                            showProgress(context);
                            authProvider.submitNameAndContinue(
                              onSuccess: () {
                                hideProgress(context);
                                EasyNavigation.pushAndRemoveUntil(
                                  context: context,
                                  page: Dashbord(),
                                );
                              },
                              onError: () {
                                hideProgress(context);
                              },
                            );
                          },
                    child: Text('Update Profile'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
