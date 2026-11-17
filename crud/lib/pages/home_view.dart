// kate: folding-indentationsensitive true; indent-width 2; replace-tabs on;

// import 'package:fedfer/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:intl/intl.dart';

import 'package:fedfer/view.dart';
import 'home_code.dart';
import '../model/sample_object.dart';

class HomeView extends FedView {
  const HomeView({super.key, required super.code});

  @override
  Widget build(BuildContext context) {
    HomeCode viewCode = super.code as HomeCode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Root.components['menu_drop_down']?.widget,
        title: Text('Available sample objects'),
      ),
      // Implement ListView.builder for dynamic and performant lists
      body: switch ((viewCode.isLoading, viewCode.error)) {
        (true, null) => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const CircularProgressIndicator()],
          ),
        ),
        (false, final Exception e) => Text('Error: $e'),
        (false, null) => ListView.builder(
          itemCount:
              viewCode.sampleObjects.length, // Dictates how many items to render
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (context, index) {
            if (index >= viewCode.sampleObjects.length) return null;
            final sampleObject = viewCode.sampleObjects[index] as SampleObject;

            return Slidable(
              key: Key(
                sampleObject.id.toString(),
              ), // Unique key is strictly required
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {
                    viewCode.onDeleteItemDismissible(context, sampleObject.id);
                  },
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      viewCode.onEditItem(sampleObject.id);
                    },
                    backgroundColor: Colors.blue,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Deleting ...'),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                      viewCode.onDeleteItem(context, sampleObject.id);
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // Design the layout for an individual article row
              child: Card(
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    sampleObject.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      sampleObject.content ?? '',
                      maxLines: 2,
                      overflow: TextOverflow
                          .ellipsis, // Adds "..." if text is too long
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'id',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        sampleObject.id.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to article details or launch a URL
                    // debugPrint('Tapped on: ${sampleObject.title}');
                  },
                ),
              ),
            );
          },
        ),
        _ => const Text('Something went wrong!'),
      },
      floatingActionButton: OverflowBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton.extended (
            onPressed: viewCode.onTest,
            tooltip: 'Generate test data',
            label: const Text('Generate test data'),

          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: viewCode.onNew,
            tooltip: 'New',
            child: const Icon(Icons.add),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
