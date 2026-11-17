import 'package:flutter/material.dart';

// import '/fedfer/model/model_export.dart';
import 'package:fedfer/view.dart';

import 'menu_dropdown_code.dart';

class MenuDropdownView extends FedView {
  const MenuDropdownView({super.key, required super.code});

  @override
  Widget build(BuildContext context) {
    MenuDropdownCode processor = super.code as MenuDropdownCode;

    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Show Menu',
          onPressed: () {
            // Toggles the dropdown menu open or closed
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      // 2. Define the list of items appearing inside the dropdown
      menuChildren: <Widget>[
        MenuItemButton(
          leadingIcon: const Icon(Icons.account_circle_outlined),
          onPressed: processor.onHome,
          child: const Text('Home'),
        ),
        const Divider(), // Clean Material 3 visual separator
        MenuItemButton(
          leadingIcon: const Icon(Icons.logout, color: Colors.red),
          onPressed: processor.onLogout,
          child: const Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
