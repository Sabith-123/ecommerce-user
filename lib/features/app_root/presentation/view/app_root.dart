import 'package:ecommerce_user_app/features/app_root/presentation/provider/app_root_provider.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppRootProvider>(
      builder: (context, appRootProvider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appRootProvider.selectIndexNumber,
            elevation: 0,
            onTap: (index) {
              appRootProvider.selectIndex(index);
            },
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,

            items: List.generate(appRootProvider.items.length, (index) {
              return BottomNavigationBarItem(
                icon: Icon(appRootProvider.items[index].icon),
                label: appRootProvider.items[index].title,
              );
            }),
          ),
          body: IndexedStack(
            index: appRootProvider.selectIndexNumber,
            children: appRootProvider.items.map((e) {
              return e.page;
            }).toList(),
          ),
        );
      },
    );
  }
}
