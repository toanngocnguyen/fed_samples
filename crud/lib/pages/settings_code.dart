import 'package:flutter/foundation.dart';

import 'package:fedfer/view.dart';

// import './elements.dart';

//import '/fedfer/model/fed_db_manager.dart';
import 'settings_view.dart';
import '../model.dart';

class SettingsCode extends FedViewCode {
  @override
  SettingsView createView(FedViewCode code) => SettingsView(key: UniqueKey(), code: code);

  void onTest() async {
    debugPrint('Setting onTest click');

    final db = await AppSetting.helper.dbManager.getDatabase();

    bool bExisted = await AppSetting.helper.isTableExists('smssetting');
    debugPrint('table smssetting existed: $bExisted');

    bExisted = await AppSetting.helper.isTableExists( 'smssetting1');
    debugPrint('table smssetting1 existed: $bExisted');

    bExisted = await AppSetting.helper.isColumnExists('lastProcessed');
    debugPrint('table smssetting - lastProcessed existed: $bExisted');

    bExisted = await AppSetting.helper.isColumnExists('lastProcessed1');
    debugPrint('table smssetting - lastProcessed1 existed: $bExisted');

    bExisted = await AppSetting.helper.isColumnExists('lastProcessed');
    debugPrint('table smssetting1 - lastProcessed existed: $bExisted');

    bExisted = await AppSetting.helper.isColumnExists('lastProcessed1');
    debugPrint('table smssetting1 - lastProcessed1 existed: $bExisted');
  }
}
