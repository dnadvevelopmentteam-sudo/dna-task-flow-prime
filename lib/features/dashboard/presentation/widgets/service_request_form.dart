import 'package:flutter/material.dart';

enum _ActiveField { title, category, priority, asset, description, none }

class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  State<ServiceRequestForm> createState() => _ServiceRequestFormState();
}

class _ServiceRequestFormState extends State<ServiceRequestForm> {
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  _ActiveField _activeField = _ActiveField.none;

  String? _selectedCategory = 'Technical Support';
  String? _selectedPriority = 'Medium';
  String? _selectedAsset = 'No specific asset';

  final List<String> _categories = [
    'Technical Support',
    'Software Request',
    'Hardware Issue',
    'Other',
  ];
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _assets = [
    'No specific asset',
    'Laptop A123',
    'Monitor B456',
    'Server S99',
  ];

  @override
  void initState() {
    super.initState();
    _titleFocus.addListener(_handleTitleFocusChange);
    _descriptionFocus.addListener(_handleDescriptionFocusChange);
  }

  @override
  void dispose() {
    _titleFocus.removeListener(_handleTitleFocusChange);
    _descriptionFocus.removeListener(_handleDescriptionFocusChange);
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  void _handleTitleFocusChange() {
    setState(() {
      if (_titleFocus.hasFocus) {
        _activeField = _ActiveField.title;
      } else if (_activeField == _ActiveField.title) {
        _activeField = _ActiveField.none;
      }
    });
  }

  void _handleDescriptionFocusChange() {
    setState(() {
      if (_descriptionFocus.hasFocus) {
        _activeField = _ActiveField.description;
      } else if (_activeField == _ActiveField.description) {
        _activeField = _ActiveField.none;
      }
    });
  }

  Widget _buildLabel(String label, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
          children: isRequired
              ? [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _buildFieldWrapper({
    required Widget child,
    required _ActiveField field,
    double? height,
  }) {
    final bool isActive = _activeField == field;
    return GestureDetector(
      onTap: () {
        if (field != _ActiveField.title && field != _ActiveField.description) {
          setState(() {
            _activeField = field;
          });
        }
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isActive ? Colors.blue.shade700 : Colors.grey.shade300,
            width: isActive ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: child,
        ),
      ),
    );
  }

  Color _getPriorityChipColor(String value) {
    if (value == 'Medium') return Colors.orange.shade100;
    if (value == 'High') return Colors.red.shade100;
    if (value == 'Critical') return Colors.red.shade400;
    return Colors.grey.shade200;
  }

  Color _getPriorityTextColor(String value) {
    if (value == 'Medium') return Colors.orange.shade700;
    if (value == 'High') return Colors.red.shade700;
    if (value == 'Critical') return Colors.white;
    return Colors.grey.shade800;
  }

  Widget _buildPriorityChip(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getPriorityChipColor(value),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: _getPriorityTextColor(value),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Raise Service Request',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Submit a request for technical support, hardware issues, or other \nassistance.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Title', isRequired: true),
                  _buildFieldWrapper(
                    field: _ActiveField.title,
                    height: 48,
                    child: TextFormField(
                      focusNode: _titleFocus,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Brief description of the issue',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Category', isRequired: true),
                  _buildFieldWrapper(
                    field: _ActiveField.category,
                    height: 48,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedCategory,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14,
                          ),
                          items: _categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                              _activeField = _ActiveField.category;
                            });
                          },
                          onTap: () {
                            setState(
                              () => _activeField = _ActiveField.category,
                            );
                          },
                          hint: const Text("Select category"),
                          padding: const EdgeInsets.only(right: 12, left: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Priority', isRequired: true),
                  _buildFieldWrapper(
                    field: _ActiveField.priority,
                    height: 48,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedPriority,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14,
                          ),
                          selectedItemBuilder: (context) {
                            return _priorities.map((String value) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: _buildPriorityChip(value),
                              );
                            }).toList();
                          },
                          items: _priorities.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: _buildPriorityChip(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPriority = newValue;
                              _activeField = _ActiveField.priority;
                            });
                          },
                          onTap: () {
                            setState(
                              () => _activeField = _ActiveField.priority,
                            );
                          },
                          hint: const Text("Select priority"),
                          padding: const EdgeInsets.only(right: 12, left: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Related Asset', isRequired: false),
                  _buildFieldWrapper(
                    field: _ActiveField.asset,
                    height: 48,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedAsset,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14,
                          ),
                          items: _assets.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedAsset = newValue;
                              _activeField = _ActiveField.asset;
                            });
                          },
                          onTap: () {
                            setState(() => _activeField = _ActiveField.asset);
                          },
                          hint: Text(
                            "No specific asset",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          padding: const EdgeInsets.only(right: 12, left: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Description', isRequired: true),
                  _buildFieldWrapper(
                    field: _ActiveField.description,
                    height: 100,
                    child: TextFormField(
                      focusNode: _descriptionFocus,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'Provide detailed information about your request...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        minimumSize: const Size(140, 48),
                      ),
                      child: const Text(
                        'Submit Request',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
