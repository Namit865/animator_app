import 'package:animator_app/Model/theme.dart';
import 'package:flutter/cupertino.dart';

class themeProvider extends ChangeNotifier {
  theme Theme = theme(isdark: false);

  themeToggle(){

    Theme.isdark!=Theme.isdark;
    notifyListeners();
  }

}