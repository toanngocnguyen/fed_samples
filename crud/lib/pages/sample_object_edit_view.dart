import 'package:flutter/material.dart';

import 'package:fedfer/view.dart';

import 'sample_object_edit_code.dart';

class SampleObjectEditView extends FedView {
  const SampleObjectEditView({super.key, required super.code});

  @override
  Widget build(BuildContext context) {
    SampleObjectEditCode viewCode = super.code as SampleObjectEditCode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Root.elements['menu_drop_down']?.widget,
        title: Text('Sample Object Edit'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            tooltip: 'Cancel',
            onPressed: viewCode.onCancel,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save',
            onPressed: () => viewCode.onSave(context),
          ),
        ],
      ),
      // a Form widget combined with multiple TextFormField widgets.
      body: switch ((viewCode.isLoading, viewCode.error)) {
        (true, null) => const CircularProgressIndicator(),
        (false, final Exception e) => Text('Error: $e'),
        (false, null) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewCode.formKey,
            child: ListView(
              children: [
                // Title Field
                TextFormField(
                  initialValue: viewCode.sampleObject.title ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewCode.sampleObject.title = value?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 16),

                // Tags Field
                TextFormField(
                  initialValue: viewCode.sampleObject.tags ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Tags (comma separated)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.label),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    viewCode.sampleObject.tags = value?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  initialValue: viewCode.sampleObject.content ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  maxLines:
                      10, // Allows for a larger, multi-line paragraph input
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Content cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewCode.sampleObject.content = value?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 24),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Cancel Button
                    TextButton.icon(
                      onPressed: viewCode.onCancel,
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Save Button
                    ElevatedButton.icon(
                      onPressed: () => viewCode.onSave(context),
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _ => const Text('Something went wrong!'),
      },
      resizeToAvoidBottomInset: false,
    );
  }
}
