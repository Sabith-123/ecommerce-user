import 'package:ecommerce_user_app/features/app_root/data/model/botton_navigation_model.dart';
import 'package:ecommerce_user_app/features/categories/presentation/view/categories.dart';
import 'package:ecommerce_user_app/features/dashbord/presentation/view/dashbord.dart';
import 'package:flutter/material.dart';

class AppRootProvider extends ChangeNotifier {
  int selectIndexNumber = 0;

  List<BottonNavigationModel> items = [
    BottonNavigationModel(
      page: Dashbord(),
      icon: Icons.home_max,
      title: "Home",
    ),
    BottonNavigationModel(
      page: Categories(),
      icon: Icons.store,
      title: "Category",
    ),
    BottonNavigationModel(
      page: Dashbord(),
      icon: Icons.shopping_cart_outlined,
      title: "Cart",
    ),
    BottonNavigationModel(
      page: Dashbord(),
      icon: Icons.person,
      title: "Profile",
    ),
  ];

  void selectIndex(int index) {
    selectIndexNumber = index;
    notifyListeners();
  }
}
