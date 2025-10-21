import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

import 'tasks_details_dialog_content.dart';

const Color _primaryBlue = Color(0xFF007bff);
const Color _lightGrey = Color(0xFFF0F0F0);
const Color _darkGrey = Color(0xFF424242);
const Color _borderColor = Color(0xFFDDDDDD);

class EditTaskModal extends StatefulWidget {
  const EditTaskModal({super.key});

  @override
  State<EditTaskModal> createState() => EditTaskModalState();
}

class EditTaskModalState extends State<EditTaskModal> {
  final List<String> _selectedTags = [];
  final List<String> _quickTags = [
    'Income Tax',
    'Audit',
    'Compliance',
    'ROC Filing',
    'TDS Return',
    'ESJ/PF',
    'Labour Law',
    'FEMA',
  ];

  void _removeTag(String tag) {
    setState(() {
      _selectedTags.remove(tag);
      if (!_quickTags.contains(tag)) {
        _quickTags.add(tag);
        _quickTags.sort();
      }
    });
  }

  void _addTag(String tag) {
    if (!_selectedTags.contains(tag)) {
      setState(() {
        _selectedTags.add(tag);
        _quickTags.remove(tag);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

      title: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Edit Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),

      content: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const InputFocusField(
              label: 'Task Title',
              initialValue: 'Income Tax Return - Q2 Review',
              maxLines: 1,
            ),
            const SizedBox(height: 15),

            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.w500, color: _darkGrey),
            ),
            const InputFocusField(
              label: 'Description',
              hintText: 'Enter task description',
              maxLines: 5,
            ),
            const SizedBox(height: 20),

            const CustomDropdown(
              label: 'Client',
              currentValue: 'ABC Corp (ABC)',
              items: ['ABC Corp (ABC)', 'XYZ Inc', 'Another Client'],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    label: 'Priority',
                    currentValue: 'Medium',
                    items: const ['High', 'Medium', 'Low'],
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: InputFocusField(
                    label: 'Estimated Hours',
                    initialValue: '6',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const DueDateTimeButton(
              label: 'Due Date & Time',
              initialDateTime: 'August 22nd, 2024 at 05:30',
            ),
            const SizedBox(height: 20),

            const Text(
              'Tags',
              style: TextStyle(fontWeight: FontWeight.w500, color: _darkGrey),
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minHeight: 40),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: _borderColor, width: 1.0),
              ),
              child: _selectedTags.isEmpty
                  ? Text(
                      'No tags selected',
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _selectedTags
                          .map(
                            (tag) =>
                                SelectedTagChip(tag: tag, onRemove: _removeTag),
                          )
                          .toList(),
                    ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Quick Add Tags',
              style: TextStyle(fontWeight: FontWeight.w500, color: _darkGrey),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _quickTags
                  .map((tag) => QuickAddTagChip(tag: tag, onAdd: _addTag))
                  .toList(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Add Custom Tag:',
              style: TextStyle(fontWeight: FontWeight.w500, color: _darkGrey),
            ),
            const SizedBox(height: 8),
            CustomTagInput(onTagAdded: _addTag),
            const SizedBox(height: 20),
          ],
        ),
      ),

      actionsPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                side: const BorderSide(color: _borderColor),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                elevation: 0,
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
