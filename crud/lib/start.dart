import 'package:flutter/material.dart';
import 'package:fedfer/view.dart';
import 'package:fed_auth/auth.dart';

import './pages.dart';
import './components.dart';
import './model.dart';

class Start {
  static Future<Widget> getHome() async {
    // define database and models
    await DBManager.defaultDb.init();

    // define view-shared components
    // global menu
    var menuDropDown =FedComponent(MenuDropdownCode());

    Root.components['menu_drop_down'] = menuDropDown;

    // define pages
    var loginPage = FedPage(LoginCode());
    var homePage = FedPage(HomeCode());
    var sampleObjectEditPage = FedPage(SampleObjectEditCode());
    var settingsPage = FedPage(SettingsCode());

    Root.addPage('/login', loginPage);
    Root.addPage('/settings', settingsPage);

    Root.addPage('/', homePage);
    Root.addPage('/home', homePage);
    Root.addPage('/sampleobject/edit', sampleObjectEditPage);

    // if there is an authenticated session, then restore it.
    Authentication().initializeSession();

    if (Authentication().isLogined){
      Root.loadPage('/home');
    }
    else
    {
      Root.loadPage('/login');
    }

    // check if any page is loaded
    if (Root.widget == null) return Text('No layout set');

    return Root.widget!;
  }
}
