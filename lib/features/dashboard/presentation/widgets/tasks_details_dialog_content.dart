import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

import 'edit_tasks_dialog.dart';
import 'reassign_tasks_dialog.dart';

const Color _primaryBlue = Color(0xFF007bff);
const Color _lightGrey = Color(0xFFF0FFff);
const Color _darkGrey = Color(0xFF424242);
const Color _borderColor = Color(0xFFDDDDDD);
const Color _redOverdue = Color(0xFFDD3333);
const Color _bgRedOverdue = Color(0xFFFFECEC);
const Color _redHigh = Color(0xFFDD3333);
const Color _bgRedHigh = Color(0xFFFFECEC);
const Color _lightBlueHoverBg = Color(0xFFE8F3FF);
const Color _greenTodo = Color(0xFF00C853);

class _CustomStatusDropdown extends StatefulWidget {
  const _CustomStatusDropdown();

  @override
  State<_CustomStatusDropdown> createState() => _CustomStatusDropdownState();
}

class _CustomStatusDropdownState extends State<_CustomStatusDropdown> {
  String? _selectedStatus;
  bool _isMenuOpen = false;
  final List<String> _statusOptions = [
    'To Do',
    'In Progress',
    'Done (Restricted)',
    'Review (TM)',
    'Review (EP)',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _isMenuOpen;

    return Container(
      width: 170,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: isFocused ? _primaryBlue : Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatus,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: isFocused ? _primaryBlue : Colors.black,
            size: 20,
          ),
          onTap: () {
            setState(() {
              _isMenuOpen = !_isMenuOpen;
            });
          },
          onChanged: (String? newValue) {
            setState(() {
              _selectedStatus = newValue!;
              _isMenuOpen = false;
            });
          },
          selectedItemBuilder: (context) {
            return _statusOptions.map((String value) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              );
            }).toList();
          },
          items: _statusOptions.map<DropdownMenuItem<String>>((String value) {
            final bool isToDo = value == 'To Do';
            final bool isRestricted = value == 'Done (Restricted)';

            return DropdownMenuItem<String>(
              value: value,
              child: Builder(
                builder: (BuildContext context) {
                  return Container(
                    color: isToDo ? _greenTodo : Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isToDo
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isToDo
                            ? Colors.white
                            : isRestricted
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ManageButtonWithHover extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final Widget icon;

  const _ManageButtonWithHover({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  State<_ManageButtonWithHover> createState() => _ManageButtonWithHoverState();
}

class _ManageButtonWithHoverState extends State<_ManageButtonWithHover> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _isHovering ? _primaryBlue : Colors.black;
    final Color borderColor = _isHovering ? _primaryBlue : Colors.grey[300]!;
    final Color bgColor = _isHovering ? _lightBlueHoverBg : Colors.white;

    Widget iconWidget = widget.icon;
    if (iconWidget is Icon) {
      iconWidget = Icon(
        iconWidget.icon,
        size: iconWidget.size ?? 20,
        color: currentColor,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              const SizedBox(width: 4),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: currentColor,
                  fontWeight: FontWeight.w500,
                  fontSize: context.scaleFont(14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// ========================= 1. UI FOR THE EDIT MODAL (KEEPING AS IS FOR CONTEXT) =========================
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

// --- 1.6 Due Date/Time Button (Keeping as-is) ---

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
            // dialogTheme: const DialogTheme(backgroundColor: Colors.white),
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
// ========================= 2. UI FOR TASK DETAILS MODAL =========================
// =========================================================================

// --- 2.1 Helper Widget for the Breadcrumb Navigation (ADJUSTED) ---
class _TaskBreadcrumb extends StatelessWidget {
  const _TaskBreadcrumb();

  Widget _breadcrumbItem(String text, {bool isCurrent = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
            color: isCurrent ? Colors.black : Colors.grey[700],
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
        _breadcrumbItem('Acme Corporation'),
        _breadcrumbItem('GSTR-1 Filing for Acme Corp', isCurrent: true),
      ],
    );
  }
}

// --- 2.2 Left Panel Header (Breadcrumb + Close Button) (ADJUSTED) ---
class _LeftPanelHeader extends StatelessWidget {
  final VoidCallback onClose;

  const _LeftPanelHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [_TaskBreadcrumb(), Spacer()],
      ),
    );
  }
}

// --- 2.3 Section: Task Title and Subtitle (ADJUSTED) ---

class _TaskTitleSection extends StatelessWidget {
  const _TaskTitleSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GSTR-1 Filing for Acme Corp',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Acme Corporation | Service Name',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF707070),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2.4 Section: Task Info Badges (Chips) (ADJUSTED) ---
class _TaskInfoBadges extends StatelessWidget {
  const _TaskInfoBadges();

  Widget _buildChip({
    required String label,
    Color backgroundColor = Colors.grey,
    Color textColor = Colors.black,
    IconData? icon,
    String? initialLetter,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
        border: (initialLetter != null)
            ? Border.all(color: Colors.grey[300]!, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (initialLetter != null)
            Container(
              margin: const EdgeInsets.only(right: 6),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  initialLetter,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(icon, size: 12, color: textColor),
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip(
              label: 'Overdue 40d 20h',
              backgroundColor: _bgRedOverdue,
              textColor: _redOverdue,
              icon: Icons.access_time,
            ),
            _buildChip(
              label: 'High',
              backgroundColor: _bgRedHigh,
              textColor: _redHigh,
            ),
            _buildChip(
              label: '4h est.',
              backgroundColor: const Color(0xFFF0F0F0),
              textColor: Colors.black,
            ),
            _buildChip(
              label: 'Priya Sharma',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              initialLetter: 'P',
            ),
            _buildChip(
              label: 'GST Filing',
              backgroundColor: const Color(0xFFF0F0F0),
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2.5 Reusable Action Button with Hover State (ADJUSTED) ---
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
    // --- MODIFIED LOGIC HERE ---
    // If hovering, set colors to _primaryBlue and background to a lighter blue.
    // If not hovering, set colors to black and border to light grey.
    final Color currentColor = _isHovering ? _primaryBlue : Colors.black;
    final Color borderColor = _isHovering ? _primaryBlue : Colors.grey[300]!;
    final Color bgColor = _isHovering ? _lightBlueHoverBg : Colors.white;
    // --- END MODIFIED LOGIC ---

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: InkWell(
          onTap: widget.onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Container(
            width: widget.isEllipsis ? 35 : null,
            height: 30,
            padding: widget.isEllipsis
                ? null
                : const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor, // Use calculated background color
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: borderColor,
                width: 1.0,
              ), // Use calculated border color
            ),
            child: widget.isEllipsis
                ? Center(
                    child: Icon(
                      widget.icon,
                      size: 16,
                      color: currentColor,
                    ), // Use calculated color
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.icon,
                        size: 16,
                        color: currentColor,
                      ), // Use calculated color
                      const SizedBox(width: 6),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: currentColor, // Use calculated color
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
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

// --- 2.6 Section: Task Action Buttons (ADJUSTED) ---
class _TaskActionButtons extends StatelessWidget {
  const _TaskActionButtons();

  void _showDialog(BuildContext context, String action) {
    if (action == 'Edit') {
      showDialog(
        context: context,
        builder: (BuildContext context) => const EditTaskModal(),
      );
    } else if (action == 'Reassign') {
      showDialog(
        context: context,
        builder: (BuildContext context) => const ReassignTaskModal(),
      );
    } else {
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
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
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
              label: 'Attach Files',
              onTap: () => _showDialog(context, 'Attach Files'),
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
  final bool showCheckmark;

  // Define the non-selected background color based on the overall task detail background
  static const Color _tabInActiveBg = Color(
    0xFFF0F0F0,
  ); // A light grey for the inactive tabs/tab area

  const _TabItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.badgeCount,
    this.showCheckmark = false,
  });

  @override
  Widget build(BuildContext context) {
    // Colors for text/icon are always black (or blue for checkmark)
    final Color color = Colors.black;

    // Active tab has a white background. Inactive tabs have the overall section background color.
    final Color backgroundColor = isSelected ? Colors.white : _tabInActiveBg;

    return Padding(
      padding: EdgeInsets.only(
        right: 4.0,
      ), // Reduced right padding to bring tabs closer
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: isSelected ? Colors.grey[300]! : _tabInActiveBg,
                width: 1.0,
              ),
              // Only apply top/side borders if selected
              borderRadius: isSelected
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    )
                  : null,
            ),
            // Mask the bottom border if selected to let the bottom line pass through
            child: Container(
              decoration: isSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1.0),
                      ),
                    )
                  : null,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Main Icon
                      Icon(icon, size: 16, color: color),
                      const SizedBox(width: 6),
                      // Label
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
                      const SizedBox(width: 8),

                      // Checkmark Icon (Conditional)
                      if (showCheckmark)
                        const Icon(
                          Icons.check_circle,
                          size: 14,
                          color: _primaryBlue,
                        ),
                      if (showCheckmark) const SizedBox(width: 8),

                      // Badge Count (Conditional)
                      if (badgeCount != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            // Orange badge for Approvals, light grey for Screenshots
                            color: label == 'Approvals'
                                ? Colors.orange.shade200
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '$badgeCount',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2.8 Section: Status and Tabs (Tabs Widget) (MODIFIED TO MATCH UI) ---
class _TaskTabs extends StatelessWidget {
  const _TaskTabs();

  void _onTabSelect(String tabName) {
    print('Tab selected: $tabName');
  }

  @override
  Widget build(BuildContext context) {
    // We assume 'Overview' is always selected initially based on the image
    const String selectedTab = 'Overview';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Row (Dropdown is correct from previous step)
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              _CustomStatusDropdown(),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Tabs Row Container
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            // The solid horizontal line below the tabs
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Overview - Selected Tab (White background, borders)
                _TabItem(
                  icon: Icons
                      .article_outlined, // Icon matching the paper icon in UI
                  label: 'Overview',
                  isSelected: selectedTab == 'Overview',
                  onTap: () => _onTabSelect('Overview'),
                ),
                // Time - Checkmark shown
                _TabItem(
                  icon: Icons.access_time,
                  label: 'Time',
                  isSelected: selectedTab == 'Time',
                  showCheckmark: true,
                  onTap: () => _onTabSelect('Time'),
                ),
                // Screenshots - Badge Count 12
                _TabItem(
                  icon: Icons.monitor_outlined,
                  label: 'Screenshots',
                  badgeCount: 12,
                  isSelected: selectedTab == 'Screenshots',
                  onTap: () => _onTabSelect('Screenshots'),
                ),
                // Approvals - Badge Count 1 (Orange Background for approval/action needed)
                _TabItem(
                  icon: Icons.check_circle_outline,
                  label: 'Approvals',
                  badgeCount: 1,
                  isSelected: selectedTab == 'Approvals',
                  onTap: () => _onTabSelect('Approvals'),
                ),
                // History - Normal
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

// --- 2.9 Section: Task Assignment/Quick Assign (New Section to Match Image Content) ---
class _AskAssignmentSection extends StatelessWidget {
  const _AskAssignmentSection();

  void _onManageTapped(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Manage Subtasks action triggered.')),
    );
  }

  Widget _buildQuickAssignChip(String label, {required bool isSelected}) {
    final Color textColor = isSelected ? Colors.white : Colors.black;
    final Color iconColor = isSelected ? Colors.white : Colors.grey.shade600;
    final Color borderColor = isSelected ? _primaryBlue : Colors.grey[300]!;
    final Color bgColor = isSelected ? _primaryBlue : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      margin: const EdgeInsets.only(right: 8.0, top: 8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_outline, size: 16, color: iconColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the "Staff" badge
  Widget _buildStaffBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_outline, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            'Staff',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 20,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Task Assignment',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(4.0),
                  //   border: Border.all(color: Colors.grey[300]!),
                  // ),
                  child: Row(
                    children: [
                      // Icon(
                      //   Icons.keyboard_arrow_down,
                      //   size: 20,
                      //   color: Colors.black,
                      // ),
                      // SizedBox(width: 4),
                      // Text(
                      //   'Manage',
                      //   style: TextStyle(fontSize: 14, color: Colors.black),
                      // ),
                      _ManageButtonWithHover(
                        onTap: () => _onManageTapped(context),
                        text: 'Manage',
                        icon: const Icon(Icons.person, size: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              'Assigned To',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.orange,
                    child: Text(
                      'P',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Priya Sharma',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Text(
                    'Since 10/24/2025',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  _buildStaffBadge(),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Assign Label
            const Text(
              'Quick Assign',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),

            // Quick Assign Chips
            Wrap(
              children: [
                _buildQuickAssignChip('Priya', isSelected: true),
                _buildQuickAssignChip('Priya', isSelected: false),
                _buildQuickAssignChip('Priya', isSelected: false),
                _buildQuickAssignChip('Priya', isSelected: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2.10 Section: Description (New Section to Match Image Content) ---

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      // --- START: Main Card Container ---
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(8.0), // Curved edges
          border: Border.all(color: Colors.grey[300]!), // Subtle border
        ),
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Icon + Description Text
            Row(
              children: [
                Icon(
                  Icons.filter_list, // Filter icon (as seen in the image)
                  size: 20,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16), // Separator between header and content
            // Description Content (Placed directly inside the main card's padding)
            // Note: The text itself is multi-line, occupying the remaining space.
            const Text(
              'Complete the assigned task according to specifications and client requirements.',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            // Use a large vertical padding/spacer at the bottom to maintain the height shown
            const SizedBox(height: 40),
          ],
        ),
      ),
      // --- END: Main Card Container ---
    );
  }
}

// --- 2.11 Section: Subtasks (New Section to Match Image Content) ---

class _SubtasksSection extends StatelessWidget {
  const _SubtasksSection();

  void _onManageTapped(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Manage Subtasks action triggered.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtasks (0)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                _ManageButtonWithHover(
                  onTap: () => _onManageTapped(context),
                  text: 'Add Subtask',
                  icon: const Icon(Icons.add, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  'No subtasks yet. Add one to break down this task.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2.12 Section: Attachments (New Section to Match Image Content) ---
class _AttachmentsSection extends StatelessWidget {
  const _AttachmentsSection();

  Widget _buildAttachmentItem({
    required String fileName,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: _primaryBlue, size: 24),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                side: const BorderSide(color: Color(0x1A000000), width: 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
              child: const Text(
                'Download',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Attachments (2)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0x1A000000),
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                  ),
                  icon: const Icon(
                    Icons.add,
                    size: 14,
                    color: Color(0xFF000000),
                  ),
                  label: const Text(
                    'Upload File',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            _buildAttachmentItem(
              fileName: 'GST_Return_Draft.pdf',
              date: 'Priya Sharma • 3.4 MB • 2024-09-15',
            ),
            _buildAttachmentItem(
              fileName: 'Input_Tax_Invoices.xlsx',
              date: 'Rohit Verma • 1.2 MB • 2024-09-15',
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2.13 Section: Recent Activity (New Section to Match Image Content) ---
class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              '• Status changed to In Progress',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 2),
            Text(
              'Priya Sharma • 3 hours ago',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2.14 Left Panel Content (Combines all Left-Side Widgets) (ADJUSTED) ---

class _LeftPanelContent extends StatelessWidget {
  final VoidCallback onClose;
  const _LeftPanelContent({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const _LeftPanelHeader(onClose: onClose),
          const _TaskTitleSection(),
          const _TaskInfoBadges(),
          const _TaskActionButtons(),
          Divider(),
          SizedBox(height: 10),
          const _TaskTabs(),
          const _AskAssignmentSection(),
          const _DescriptionSection(),
          const _SubtasksSection(),
          const _AttachmentsSection(),
          const _RecentActivitySection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// --- 2.15 Right Side Panel Content (ADJUSTED) ---
class _RightSidePanelContent extends StatelessWidget {
  const _RightSidePanelContent();

  Widget _buildCommentBubble({
    required String initials,
    required String name,
    required String time,
    required List<Widget> children,
    required Color avatarColor,
    bool isActivity = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture/Initials
          CircleAvatar(
            radius: 16,
            backgroundColor: avatarColor,
            child: Text(
              initials,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          // Comment/Activity Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserComment(String text) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF), // Light blue bubble
        borderRadius: BorderRadius.circular(
          8.0,
        ).copyWith(topLeft: const Radius.circular(0)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Widget _buildActivityLog(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Comments & Activity',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(), // Close Modal
                child: const Icon(Icons.close, size: 18, color: Colors.black),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Colors.grey),

        // Comments Area
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 8.0),
            children: [
              _buildCommentBubble(
                initials: 'P',
                name: 'Priya Sharma',
                time: 'Aug 10',
                avatarColor: Colors.purple,
                children: [
                  _buildActivityLog(
                    'Reviewed initial data and found some discrepancies in Input Tax credits.',
                  ),
                ],
              ),
              _buildCommentBubble(
                initials: 'R',
                name: 'Rohit Verma',
                time: 'Aug 10',
                avatarColor: Colors.orange,
                children: [
                  _buildActivityLog(
                    'Can you share the detailed breakdown? I need to re-verify the calculations.',
                  ),
                ],
              ),
              _buildCommentBubble(
                initials: 'P',
                name: 'You',
                time: 'Aug 11',
                avatarColor: _primaryBlue,
                children: [
                  _buildUserComment(
                    'Mailing client clarification on new invoices (GST_Calculations.xlsx) and supporting documents.',
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'GST_Calculations.xlsx',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildCommentBubble(
                initials: 'P',
                name: 'Priya Sharma15',
                time: 'Aug 12 | 10:40',
                avatarColor: Colors.purple,
                children: [
                  _buildActivityLog(
                    'Reviewed initial data and found some discrepancies in Input Tax credits.',
                  ),
                ],
              ),
              // Spacer to push the input field to the bottom
              const SizedBox(height: 20),
            ],
          ),
        ),

        // Comment Input Field
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[300]!, width: 1.0),
            ),
          ),
          child: Column(
            children: [
              // Text Field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Action Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_file,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_outline,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Press Send, Shift+Enter for new line',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- 2.16 Main Widget Wrapper (ADJUSTED) ---
class TaskDetailsModalContainer extends StatelessWidget {
  final bool isMobile;
  const TaskDetailsModalContainer({super.key, required this.isMobile});

  void _handleClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // A typical desktop-sized view
    final double maxWidth = screenWidth * (isMobile ? 0.95 : 0.85);
    final double maxHeight = screenHeight * (isMobile ? 0.90 : 0.90);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: _LeftPanelContent(
                      onClose: () => _handleClose(context),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                      border: Border(
                        left: BorderSide(color: Colors.grey[300]!, width: 1.0),
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
    );
  }
}
