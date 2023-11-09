import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final void Function(String?) onSavedTitle;
  final void Function(String?) onSavedDescription;

  const NoteFormWidget({
    super.key,
    this.title = '',
    this.description = '',
    required this.onSavedTitle,
    required this.onSavedDescription,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onSaved: onSavedTitle,
                maxLines: 1,
                initialValue: title,
                style: Theme.of(context).textTheme.headlineSmall,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                ),
                validator: (title) => title != null && title.isEmpty
                    ? 'The title cannot be empty'
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                onSaved: onSavedDescription,
                maxLines: 5,
                initialValue: description,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type something...',
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                ),
                validator: (title) => title != null && title.isEmpty
                    ? 'The description cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
}
