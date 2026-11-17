import 'package:flutter/material.dart';

import 'package:fedfer/view.dart';
import '../model.dart';

import 'sample_object_edit_view.dart';

class SampleObjectEditCode extends FedViewCode {
  @override
  SampleObjectEditView createView(FedViewCode code) =>
      SampleObjectEditView(key: UniqueKey(), code: code);

  SampleObject sampleObject = SampleObject();

  final formKey = GlobalKey<FormState>();

  @override
  Future<bool> onLoad() async {
    isLoading = true;
    await super.onLoad();

    String? inputId = viewRequest.queryParams['id'];

    if (inputId != null && inputId != '') {
      await sampleObject.load(inputId);
    } else {
      sampleObject.loadMap({'id': ''});
    }

    onBuild(-1);
    isLoading = false;
    return true; // for refresh view
  }

  void onSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving ...'), duration: Duration(milliseconds: 300)),
      );

      sampleObject
          .save()
          .catchError((error) {
            debugPrint("Error occurred: $error");

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error occurred: $error'),
                  duration: Duration(milliseconds: 300),
                ),
              );
            }
            return error.toString();
          });
    }
  }

  void onCancel() {
    Root.loadPage('/home');
  }
}
