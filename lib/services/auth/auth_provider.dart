import 'package:flutter/foundation.dart';
import 'package:justlearn/services/shared_preference.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAlreadyLogin = false;

  bool get isAlreadyLogin => _isAlreadyLogin;

  isLoginAlready() async {
    bool checkExist = await SharedPref().isExisting('isLogin');
    if (checkExist) {
      bool checkLogin = await SharedPref().getIsLogin("isLogin");
      _isAlreadyLogin = checkLogin;
      notifyListeners();
    } else {
      _isAlreadyLogin = false;
      notifyListeners();
    }
  }

  logout(){
    _isAlreadyLogin = false;
    notifyListeners();
  }
}
