// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fedfer/view.dart';
import 'package:fedfer/model.dart';

// import './elements.dart';
import '../model.dart';

import 'home_view.dart';

class HomeCode extends FedViewCode {
  // HomeCode({super.newWidget});

  late List<FedObject> sampleObjects;

  Future<void> loadPreviousData() async {
    sampleObjects = await FedObject.getList(SampleObject.helper);
  }

  Future<void> loadNextData() async {
    sampleObjects = await FedObject.getList(SampleObject.helper);
  }

  @override
  HomeView createView(FedViewCode code) =>
      HomeView(key: UniqueKey(), code: code);

  @override
  Future<bool> onLoad() async {
    isLoading = true;
    await super.onLoad();
    await loadNextData();
    isLoading = false;

    return true; // for refresh view
  }

  void onEditItem(String? id) {
    Root.loadPage('/sampleobject/edit?id=$id');
  }

  Future<void> onDeleteItem(BuildContext context, String? id) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleting ...'),
        duration: Duration(milliseconds: 300),
      ),
    );
    if (id == null || id == '') return;

    SampleObject.helper.delete(id)
        .then((_) {
          loadNextData().then((value) {
            if (context.mounted) {
              refreshView();
            }
          });
        })
        .catchError((error) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error occurred: $error'),
                duration: Duration(milliseconds: 300),
              ),
            );
          }
        });
  }

  Future<void> onDeleteItemDismissible(BuildContext context, String? id) async {
    if (id == null || id == '') return;

    await FedObject.delete(SampleObject.helper, id);
    await loadNextData();
  }

  void onNew() {
    Root.loadPage('/sampleobject/edit');
  }

  Future<void> createTestData() async {
    List<SampleObject> testObjects = [
      SampleObject(id: '', title: 'title 1', content: '1 content'),
      SampleObject(id: '', title: 'title 2', content: '2 content'),
      SampleObject(id: '', title: 'title 3', content: '3 content'),
      SampleObject(id: '', title: 'title 4', content: '3 content'),
      SampleObject(id: '', title: 'title 5', content: '4 content'),
      SampleObject(id: '', title: 'title 6', content: '5 content'),
    ];

    for (int i = 0; i < testObjects.length; i++) {
      SampleObject sampleObject = testObjects[i];
      await sampleObject.save();
    }
  }

  void onTest() {
    isLoading = true;
    refreshView();

    doTest();
  }

  void doTest() async {
    // isLoading = true;

    await Future.delayed(const Duration(seconds: 1));

    createTestData().then((_) {
      Root.reload();
    });
  }
}
