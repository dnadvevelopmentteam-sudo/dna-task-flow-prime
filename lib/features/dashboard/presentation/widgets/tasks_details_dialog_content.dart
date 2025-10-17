import 'package:flutter/material.dart';

import 'edit_tasks_dialog.dart';

// --- Reusable Theming ---
const Color _primaryBlue = Color(0xFF007bff);
const Color _lightGrey = Color(0xFFF0F0F0);
const Color _darkGrey = Color(0xFF424242);
const Color _borderColor = Color(0xFFDDDDDD);

// =========================================================================
// ========================= 1. UI FOR THE EDIT MODAL =========================
// =========================================================================

// --- 1.1 Reusable Widget for Fields with Focus Effect (Blue Border) ---

class InputFocusField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String? hintText;
  final int maxLines;

  const InputFocusField({
    super.key,
    required this.label,
    this.initialValue,
    this.hintText,
    this.maxLines = 1,
  });

  @override
  State<InputFocusField> createState() => InputFocusFieldState();
}

class InputFocusFieldState extends State<InputFocusField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.maxLines == 1 &&
            widget.hintText == null) // Only show label once
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: _darkGrey,
              ),
            ),
          ),
        Container(
          height: widget.maxLines == 1 ? 40 : null,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: _isFocused ? _primaryBlue : _borderColor,
              width: 1.0,
            ),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText ?? widget.label,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              border: InputBorder.none,
              isDense: true,
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

// --- 1.2 Reusable Dropdown Field with Focus Effect ---

class CustomDropdown extends StatefulWidget {
  final String label;
  final String currentValue;
  final List<String> items;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.currentValue,
    required this.items,
  });

  @override
  State<CustomDropdown> createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  bool _isFocused = false;
  String? _selectedValue;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.currentValue;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: _darkGrey,
            ),
          ),
        ),
        Focus(
          focusNode: _focusNode,
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: _isFocused ? _primaryBlue : _borderColor,
                width: 1.0,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedValue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
                items: widget.items.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// --- 1.3 Chip for Selected Tags (With close icon) ---

class SelectedTagChip extends StatelessWidget {
  final String tag;
  final Function(String) onRemove;

  const SelectedTagChip({super.key, required this.tag, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _lightGrey,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tag, style: const TextStyle(fontSize: 12, color: _darkGrey)),
          const SizedBox(width: 4),
          InkWell(
            onTap: () => onRemove(tag),
            child: const Icon(Icons.close, size: 12, color: _darkGrey),
          ),
        ],
      ),
    );
  }
}

// --- 1.4 Chip for Quick Add Tags (With hover effect) ---

class QuickAddTagChip extends StatefulWidget {
  final String tag;
  final Function(String) onAdd;

  const QuickAddTagChip({super.key, required this.tag, required this.onAdd});

  @override
  State<QuickAddTagChip> createState() => QuickAddTagChipState();
}

class QuickAddTagChipState extends State<QuickAddTagChip> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _isHovering ? _primaryBlue : _darkGrey;
    final Color backgroundColor = _isHovering
        ? _primaryBlue.withOpacity(0.1)
        : Colors.white;
    final Color borderColor = _isHovering ? _primaryBlue : _borderColor;

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: () => widget.onAdd(widget.tag),
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 14, color: currentColor),
              const SizedBox(width: 4),
              Text(
                widget.tag,
                style: TextStyle(
                  fontSize: 12,
                  color: currentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 1.5 Custom Tag Input Field ---

class CustomTagInput extends StatelessWidget {
  final Function(String) onTagAdded;

  const CustomTagInput({super.key, required this.onTagAdded});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    void addTag() {
      if (controller.text.trim().isNotEmpty) {
        onTagAdded(controller.text.trim());
        controller.clear();
      }
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: _borderColor, width: 1.0),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: (_) => addTag(),
        decoration: InputDecoration(
          hintText: 'Enter custom tag',
          hintStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.add, color: _darkGrey),
            onPressed: addTag,
          ),
          isDense: true,
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

// --- 1.6 The Stateful Edit Task Modal (MODIFIED) ---

class DueDateTimeButton extends StatefulWidget {
  final String initialDateTime;
  final String label;

  const DueDateTimeButton({
    super.key,
    required this.initialDateTime,
    required this.label,
  });

  @override
  State<DueDateTimeButton> createState() => DueDateTimeButtonState();
}

class DueDateTimeButtonState extends State<DueDateTimeButton> {
  late String _selectedDateTime;
  bool _isHovering = false;
  final Color _primaryBlue = const Color(0xFF007bff); // Primary Blue
  final Color _borderColor = const Color(0xFFDDDDDD); // Border Color
  final Color _hoverBgColor = const Color(
    0xFFE8F3FF,
  ); // Very Light Blue for Hover

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  // Helper method to open Date and Time pickers
  Future<void> _selectDateAndTime(BuildContext context) async {
    final initialDate = DateTime(2024, 8, 22, 5, 30);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
            // dialogTheme: DialogTheme(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            // ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: _primaryBlue,
                onPrimary: Colors.white,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final formattedDate =
            "${_monthName(pickedDate.month)} ${pickedDate.day}nd, ${pickedDate.year}";
        final formattedTime =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";

        setState(() {
          _selectedDateTime = "$formattedDate at $formattedTime";
        });
      }
    }
  }

  String _monthName(int month) {
    const List<String> months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    // Determine current styles based on hover state
    final Color currentColor = _isHovering
        ? _primaryBlue
        : const Color(0xFF424242); // Text and Icon Color
    final Color borderColor = _isHovering
        ? _primaryBlue
        : _borderColor; // Border Color
    final Color backgroundColor = _isHovering
        ? _hoverBgColor
        : Colors.white; // Background Color

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
            ),
          ),
        ),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: InkWell(
            onTap: () => _selectDateAndTime(context),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                // FIX: Conditionally set background color here
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: borderColor, width: 1.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: currentColor,
                    ),
                  ),
                  Text(
                    _selectedDateTime,
                    style: TextStyle(fontSize: 14, color: currentColor),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_drop_down, size: 20, color: currentColor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// ========================= 2. UI FOR THE MAIN SCREEN =======================
// =========================================================================

// --- 2.1 Helper Widget for the Breadcrumb Navigation ---
class _TaskBreadcrumb extends StatelessWidget {
  const _TaskBreadcrumb();

  Widget _breadcrumbItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Tasks', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        _breadcrumbItem('Tech Solutions Ltd'),
        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        const SizedBox(width: 5),
        const Text(
          'Income Tax Return - Q2 Review',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// --- 2.2 Left Panel Header (Breadcrumb + Close Button) ---
class _LeftPanelHeader extends StatelessWidget {
  final VoidCallback onClose;

  const _LeftPanelHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 20.0, bottom: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _TaskBreadcrumb(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: onClose,
              child: const Icon(Icons.close, size: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2.3 Section: Task Title and Subtitle ---
class _TaskTitleSection extends StatelessWidget {
  const _TaskTitleSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income Tax Return - Q2 Review',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tech Solutions Ltd | Service Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2.4 Section: Task Info Badges (Chips) ---
class _TaskInfoBadges extends StatelessWidget {
  const _TaskInfoBadges();

  Widget _buildChip({
    required String label,
    Color backgroundColor = Colors.grey,
    Color textColor = Colors.black,
    IconData? icon,
    bool isAvatar = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: isAvatar
          ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
          : const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        border: isAvatar
            ? Border.all(color: Colors.grey[300]!, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAvatar)
            const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.orange,
              child: Text(
                'R',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          if (isAvatar) const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isAvatar ? FontWeight.w500 : FontWeight.w600,
              color: textColor,
            ),
          ),
          if (icon != null) const SizedBox(width: 4),
          if (icon != null) Icon(icon, size: 14, color: textColor),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          _buildChip(
            label: 'Overdue 421d 13h',
            backgroundColor: const Color(0xFFFFECEC),
            textColor: const Color(0xFFDD3333),
          ),
          _buildChip(
            label: 'Medium',
            backgroundColor: const Color(0xFFFFF7E3),
            textColor: const Color(0xFFC09930),
          ),
          _buildChip(
            label: '6h est.',
            backgroundColor: const Color(0xFFF0F0F0),
            textColor: Colors.black,
            icon: Icons.access_time,
          ),
          _buildChip(
            label: 'Rahul Kumar',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            isAvatar: true,
          ),
          _buildChip(
            label: 'GST Filing',
            backgroundColor: const Color(0xFFF0F0F0),
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

// --- 2.5 Reusable Action Button with Hover State ---
class _ActionHoverButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isEllipsis;

  const _ActionHoverButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isEllipsis = false,
  });

  @override
  State<_ActionHoverButton> createState() => _ActionHoverButtonState();
}

class _ActionHoverButtonState extends State<_ActionHoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _isHovering ? _primaryBlue : Colors.black;
    final Color borderColor = _isHovering ? _primaryBlue : Colors.grey[300]!;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: InkWell(
          onTap: widget.onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            width: widget.isEllipsis ? 40 : null,
            height: 38,
            padding: widget.isEllipsis
                ? null
                : const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: borderColor, width: 1.0),
            ),
            child: widget.isEllipsis
                ? Center(
                    child: Icon(widget.icon, size: 20, color: currentColor),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(widget.icon, size: 18, color: currentColor),
                      const SizedBox(width: 8),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: currentColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// --- 2.6 Section: Task Action Buttons ---
class _TaskActionButtons extends StatelessWidget {
  const _TaskActionButtons();

  void _showDialog(BuildContext context, String action) {
    if (action == 'Edit') {
      // **Open the complex Edit Task Modal**
      showDialog(
        context: context,
        builder: (BuildContext context) => const EditTaskModal(),
      );
    } else {
      // **Open a simple placeholder dialog for other buttons**
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$action Clicked'),
            content: Text(
              'This is the placeholder for the "$action" dialog box content.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _ActionHoverButton(
              icon: Icons.edit_outlined,
              label: 'Edit',
              onTap: () => _showDialog(context, 'Edit'),
            ),
            _ActionHoverButton(
              icon: Icons.compare_arrows_sharp,
              label: 'Reassign',
              onTap: () => _showDialog(context, 'Reassign'),
            ),
            _ActionHoverButton(
              icon: Icons.calendar_month_outlined,
              label: 'Change Due',
              onTap: () => _showDialog(context, 'Change Due'),
            ),
            _ActionHoverButton(
              icon: Icons.add_circle_outline,
              label: 'Add Subtask',
              onTap: () => _showDialog(context, 'Add Subtask'),
            ),
            _ActionHoverButton(
              icon: Icons.attach_file,
              label: 'Attach File',
              onTap: () => _showDialog(context, 'Attach File'),
            ),
            _ActionHoverButton(
              icon: Icons.more_horiz,
              label: '',
              isEllipsis: true,
              onTap: () => _showDialog(context, 'More Options'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2.7 Reusable Tab Item for Navigation ---
class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final int? badgeCount;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? _primaryBlue : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18, color: color),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  if (badgeCount != null) const SizedBox(width: 6),
                  if (badgeCount != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? _primaryBlue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '$badgeCount',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Container(height: 2.5, width: 45, color: _primaryBlue),
        ],
      ),
    );
  }
}

// --- 2.8 Section: Status and Tabs (Tabs Widget) ---
class _TaskTabs extends StatelessWidget {
  const _TaskTabs();

  void _onTabSelect(String tabName) {
    print('Tab selected: $tabName');
  }

  @override
  Widget build(BuildContext context) {
    const String selectedTab = 'Time';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_drop_down, color: Colors.black),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Tabs Row with a bottom border
        Container(
          padding: const EdgeInsets.only(left: 40.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _TabItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Overview',
                  isSelected: selectedTab == 'Overview',
                  onTap: () => _onTabSelect('Overview'),
                ),
                _TabItem(
                  icon: Icons.access_time,
                  label: 'Time',
                  isSelected: selectedTab == 'Time',
                  onTap: () => _onTabSelect('Time'),
                ),
                _TabItem(
                  icon: Icons.monitor_outlined,
                  label: 'Screenshots',
                  badgeCount: 12,
                  isSelected: selectedTab == 'Screenshots',
                  onTap: () => _onTabSelect('Screenshots'),
                ),
                _TabItem(
                  icon: Icons.check_circle_outline,
                  label: 'Approvals',
                  badgeCount: 1,
                  isSelected: selectedTab == 'Approvals',
                  onTap: () => _onTabSelect('Approvals'),
                ),
                _TabItem(
                  icon: Icons.history,
                  label: 'History',
                  isSelected: selectedTab == 'History',
                  onTap: () => _onTabSelect('History'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// --- 2.9 Section: Info Metric Cards ---
class _InfoMetricCard extends StatelessWidget {
  final String value;
  final String label;

  const _InfoMetricCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[200]!, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '5', // Hardcoded value '5'
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1a1a1a),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoMetricsSection extends StatelessWidget {
  const _InfoMetricsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
      child: Row(
        children: const [
          _InfoMetricCard(value: '5', label: 'Total Changes'),
          _InfoMetricCard(value: '3', label: 'Contributors'),
          _InfoMetricCard(value: '2', label: 'Days Active'),
          _InfoMetricCard(value: '5', label: 'Comments'),
        ],
      ),
    );
  }
}

// --- 2.10 Section: Audit Log Title ---
class _AuditLogSection extends StatelessWidget {
  const _AuditLogSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
      child: Row(
        children: const [
          Icon(Icons.security, size: 24, color: Colors.black),
          SizedBox(width: 10),
          Text(
            'Audit Log',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2.11 Left Panel Content (Combines all Left-Side Widgets) ---
class _LeftPanelContent extends StatelessWidget {
  final VoidCallback onClose;
  const _LeftPanelContent({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LeftPanelHeader(onClose: onClose),
        const _TaskTitleSection(),
        const _TaskInfoBadges(),
        const _TaskActionButtons(),
        const _TaskTabs(),
        const _InfoMetricsSection(),
        const _AuditLogSection(),
        const Expanded(child: SizedBox.expand()),
      ],
    );
  }
}

// --- 2.12 Right Side Panel Content (Kept as provided) ---
class _RightSidePanelContent extends StatelessWidget {
  const _RightSidePanelContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 20,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Comments & Activity',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  '4',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

// --- 2.13 Main Widget Wrapper ---
class TaskDetailsModalContainer extends StatelessWidget {
  final bool isMobile;
  const TaskDetailsModalContainer({super.key, required this.isMobile});

  void _handleClose(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildBackLink(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleClose(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Back to Dashboard',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double maxWidth = screenWidth * (isMobile ? 0.95 : 0.80);
    final double maxHeight = screenHeight * (isMobile ? 0.90 : 0.85);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackLink(context),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: Material(
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 16.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _LeftPanelContent(
                        onClose: () => _handleClose(context),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: const _RightSidePanelContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
