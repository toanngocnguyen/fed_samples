import 'package:flutter/foundation.dart';

import 'package:fedfer/view.dart';
import 'package:fed_auth/auth.dart';
import 'menu_dropdown_view.dart';

class MenuDropdownCode extends FedViewCode {
  // static MenuDropdownCode menuDropdownCode = MenuDropdownCode();

  @override
  MenuDropdownView createView(FedViewCode code) =>
      MenuDropdownView(key: UniqueKey(), code: code);

  void onHome() {
    // debugPrint('Menu Home Press');
    Root.loadPage('/home');
  }

  void onLogout() {
    // debugPrint('Menu Logout Press');
    Authentication().logout();
    Root.loadPage('/login');
  }
}
