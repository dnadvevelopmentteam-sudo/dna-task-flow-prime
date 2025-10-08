import 'package:flutter/material.dart';

// --- Main Widget for the Dialog ---
class CreateAnnouncementDialog extends StatelessWidget {
  const CreateAnnouncementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Using AlertDialog for the modal pop-up.
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

      // The content widget builds the body and footer.
      content: const AnnouncementContent(),
    );
  }
}

// --- Content Widget to build the body and actions ---
class AnnouncementContent extends StatefulWidget {
  const AnnouncementContent({super.key});

  @override
  State<AnnouncementContent> createState() => _AnnouncementContentState();
}

class _AnnouncementContentState extends State<AnnouncementContent> {
  // State for the 'Publish immediately' switch and 'Priority' dropdown
  bool _publishImmediately = true;
  String? _selectedPriority = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450, // Approximate width for desktop-like dialog
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header with Title and Close Button
          _buildHeader(context),
          const Divider(height: 1),

          // 2. Main Form Content (Scrollable if content is long)
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  _buildLabel('Title *'),
                  _buildTextField('Enter announcement title', maxLines: 1),
                  const SizedBox(height: 16),

                  // Content Field
                  _buildLabel('Content *'),
                  _buildTextField('Enter announcement content', maxLines: 5),
                  const SizedBox(height: 16),

                  // Priority Dropdown
                  _buildLabel('Priority'),
                  _buildPriorityDropdown(),
                  const SizedBox(height: 16),

                  // Expiry Date Field
                  _buildLabel('Expiry Date (Optional)'),
                  _buildDateField('10/04/2025'),
                  const SizedBox(height: 16),

                  // Publish Immediately Switch
                  _buildPublishSwitch(),
                ],
              ),
            ),
          ),

          // 3. Footer/Action Buttons
          _buildFooter(context),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Create New Announcement',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(String hint, {required int maxLines}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedPriority,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: <String>['Normal', 'High', 'Urgent'].map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        },
      ).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedPriority = newValue;
        });
      },
    );
  }

  Widget _buildDateField(String initialText) {
    return TextField(
      readOnly: true, // Typically read-only for date picker
      controller: TextEditingController(text: initialText),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPublishSwitch() {
    return SwitchListTile(
      title: const Text(
        'Publish immediately',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      value: _publishImmediately,
      onChanged: (bool value) {
        setState(() {
          _publishImmediately = value;
        });
      },
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.blue,
      // Remove trailing space by making the tile tightly fitted
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: Colors.black54),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Action for Create Announcement
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text('Create Announcement'),
          ),
        ],
      ),
    );
  }
}
