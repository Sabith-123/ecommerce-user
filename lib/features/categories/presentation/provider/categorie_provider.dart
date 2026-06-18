import 'dart:developer';

import 'package:ecommerce_user_app/features/categories/data/model/categorie_model.dart';
import 'package:ecommerce_user_app/features/categories/repo/categorie_impl.dart';
import 'package:ecommerce_user_app/general/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class CategorieProvider extends ChangeNotifier {
  CategorieImpl categorieImpl;
  CategorieProvider(this.categorieImpl);
  bool isfetchCategorie = false;
  List<CategorieModel> categoriesList = [];

  Future<void> fetchCategoriesFun() async {
    isfetchCategorie = true;
    notifyListeners();
    try {
      final result = await categorieImpl.fetchCategories();
      result.fold(
        (l) {
          log(l.errorMsg);
          CToast.error(msg: 'field to Fetch categories');
        },
        (r) {
          categoriesList = r;
        },
      );
    } finally {
      isfetchCategorie = false;
      notifyListeners();
    }
  }
}
