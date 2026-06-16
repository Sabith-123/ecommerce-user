import 'package:flutter/foundation.dart';

class AppRootProvider extends ChangeNotifier {
  int selectIndexNumber = 0;
  void selectIndex(int index) {
    selectIndexNumber = index;
    notifyListeners();
  }
}
