import 'package:flutter/material.dart';

import 'package:fedfer/view.dart';
import 'settings_code.dart';

class SettingsView extends FedView {
  const SettingsView({super.key, required super.code});

  @override
  Widget build(BuildContext context) {
    SettingsCode code = super.code as SettingsCode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Root.components['menu_drop_down']?.widget,
        title: Text('Cài đặt'),
        // TODO: Add trailing buttons (102)
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, semanticLabel: 'search'),
            onPressed: () {
              // debugPrint('Search button');
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune, semanticLabel: 'filter'),
            onPressed: () {
              // debugPrint('Filter button');
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: code.onTest,
        // () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute<void>(builder: (context) => const LoginPage()),
        // );
        //},
        //tooltip: 'Increment',
        //child: const Icon(Icons.add),
        tooltip: 'Test',
        child: const Text('Test'),
      ),
      // TODO: Set resizeToAvoidBottomInset (101)
      resizeToAvoidBottomInset: false,
    );
  }

  // TODO: Make a collection of cards (102)

  // Replace this entire method
  // List<Card> _buildGridCards(BuildContext context) {
  //   List<Product> products = ProductsRepository.loadProducts(Category.all);

  //   if (products.isEmpty) {
  //     return const <Card>[];
  //   }

  //   final ThemeData theme = Theme.of(context);
  //   final NumberFormat formatter = NumberFormat.simpleCurrency(
  //     locale: Localizations.localeOf(context).toString(),
  //   );

  //   return products.map((product) {
  //     return Card(
  //       clipBehavior: Clip.antiAlias,
  //       // TODO: Adjust card heights (103)
  //       elevation: 0.0,
  //       child: Column(
  //         // TODO: Center items on the card (103)
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: 18 / 11,
  //             child: Image.asset(
  //               product.assetName,
  //               package: product.assetPackage,
  //               // TODO: Adjust the box size (102)
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
  //               child: Column(
  //                 // TODO: Align labels to the bottom and center (103)
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 // TODO: Change innermost Column (103)
  //                 children: <Widget>[
  //                   // TODO: Handle overflowing labels (103)
  //                   Text(
  //                     product.name,
  //                     style: theme.textTheme.titleMedium,
  //                     softWrap: false,
  //                     overflow: TextOverflow.ellipsis,
  //                     maxLines: 1,
  //                   ),
  //                   const SizedBox(height: 8.0),
  //                   Text(
  //                     formatter.format(product.price),
  //                     style: theme.textTheme.bodySmall,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  /*
  // TODO: Make a collection of cards (102)
  List<Card> _buildGridCards_bk_hardcode(int count) {
    List<Card> cards = List.generate(count, (int index) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // align the text to the leading edge
          children: <Widget>[
            AspectRatio(
              // decides what shape the image takes no matter what kind of image is supplied
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('diamond.png'),
            ),
            Padding(
              // brings the text in from the side a little
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Title'),
                  const SizedBox(height: 8.0),
                  Text('Secondary Text'),
                ],
              ),
            ),
          ],
        ),
      );
    });
    return cards;
  }
*/
}
