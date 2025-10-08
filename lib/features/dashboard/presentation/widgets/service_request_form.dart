import 'package:flutter/material.dart';

class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  State<ServiceRequestForm> createState() => _ServiceRequestFormState();
}

class _ServiceRequestFormState extends State<ServiceRequestForm> {
  // State variables for dropdowns
  String _selectedCategory = 'Technical Support';
  String _selectedPriority = 'Medium';
  String _selectedAsset = 'No specific asset';

  // List of items for dropdowns
  final List<String> _categories = [
    'Technical Support',
    'Hardware Issues',
    'Other Assistance',
  ];
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _assets = [
    'No specific asset',
    'Laptop/PC',
    'Monitor',
    'Software X License',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set a maximum width for the dialog on larger screens
      width: 450,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        // Set mainAxisSize to minimize the dialog height
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1. Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Raise Service Request',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Submit a request for technical support, hardware issues, or other assistance.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              // Close Button (The 'x' in the corner)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const Divider(height: 30), // Separator
          // 2. Form Fields Section
          Flexible(
            child: SingleChildScrollView(
              // Using a SingleChildScrollView in case the content overflows
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Title Field
                  _buildFormLabel('Title *'),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Brief description of the issue',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Category Dropdown
                  _buildFormLabel('Category'),
                  _buildDropdownButton(
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Priority Dropdown
                  _buildFormLabel('Priority:'),
                  _buildDropdownButton(
                    value: _selectedPriority,
                    items: _priorities,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPriority = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Related Asset Dropdown (Optional)
                  _buildFormLabel('Related Asset (Optional)'),
                  _buildDropdownButton(
                    value: _selectedAsset,
                    items: _assets,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAsset = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Description Field
                  _buildFormLabel('Description *'),
                  const TextField(
                    maxLines: 4,
                    minLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          'Provide detailed information about your request...',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 30), // Separator
          // 3. Action Buttons Section (Bottom)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Cancel Button
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(width: 10),
              // Submit Request Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement submission logic
                  debugPrint('Submit Request tapped!');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Primary color for button
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to create a label for form fields
  Widget _buildFormLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  // Helper function to create a consistent DropdownButtonFormField
  Widget _buildDropdownButton({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: const InputDecoration(
        // Remove the default internal padding/border of DropdownButtonFormField
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        // Ensures the border is visible
        border: OutlineInputBorder(),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
