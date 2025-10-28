import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart'; // REQUIRED PACKAGE

// Custom Colors
const Color kPrimaryBlue = Color(0xFF2C6BF9);
const Color kLightBorderGray = Color(0xFFDDDDDD);
const Color kDarkTextGray = Color(0xFF333333);
const Color kLightIconGray = Color(0xFF666666);
const Color kHoverBorderColor = Color(0xFF2C6BF9);

enum _ActiveField { task, date, timeFrom, timeTo, remark, justification, none }

void main() {
  runApp(const TimeEntryApp());
}

class TimeEntryApp extends StatelessWidget {
  const TimeEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Entry Dialog Mockup',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: kDarkTextGray, fontSize: 14.0),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 10.0,
          ),
          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
        ),
        primaryColor: kPrimaryBlue,
      ),
      home: const Scaffold(
        backgroundColor: Color(0xFFF4F9FC),
        body: Center(child: AddTimeEntryDialog()),
      ),
    );
  }
}

class AddTimeEntryDialog extends StatefulWidget {
  const AddTimeEntryDialog({super.key});

  @override
  State<AddTimeEntryDialog> createState() => _AddTimeEntryDialogState();
}

class _AddTimeEntryDialogState extends State<AddTimeEntryDialog> {
  // --- State Variables ---
  bool _useDurationInstead = false;
  bool _spansMidnight = false;

  final DateTime _today = DateTime.now(); // Actual today's date
  // Using a specific date (October 27, 2025) for stable UI testing:
  // final DateTime _today = DateTime(2025, 10, 27);

  late DateTime _selectedDate;

  _ActiveField _activeField = _ActiveField.none;
  bool _isDateCalendarOpen = false;

  bool _isTaskHovered = false;
  bool _isDateHovered = false;

  final FocusNode _taskFocus = FocusNode();
  final FocusNode _remarkFocus = FocusNode();
  final FocusNode _justificationFocus = FocusNode();

  // Table Calendar Controllers
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();

    // Initialize selected date to today's date
    _selectedDate = _today;
    _focusedDay = _today;
    _calendarFormat = CalendarFormat.month;

    _taskFocus.addListener(_handleFocusChange);
    _remarkFocus.addListener(_handleFocusChange);
    _justificationFocus.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _taskFocus.dispose();
    _remarkFocus.dispose();
    _justificationFocus.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      if (_taskFocus.hasFocus) {
        _activeField = _ActiveField.task;
      } else if (_remarkFocus.hasFocus) {
        _activeField = _ActiveField.remark;
      } else if (_justificationFocus.hasFocus) {
        _activeField = _ActiveField.justification;
      } else {
        _activeField = _ActiveField.none;
      }
    });
  }

  void _selectDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _isDateCalendarOpen = false; // Close calendar
      _activeField = _ActiveField.none; // Remove active state
      _focusedDay = newDate; // Focus on the newly selected day
    });
  }

  String _formatDateWithSuffix(DateTime date) {
    String day = DateFormat('d').format(date);
    String suffix;
    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }
    return DateFormat('MMMM ').format(date) +
        day +
        suffix +
        DateFormat(', y').format(date);
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String label, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 16.0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: kDarkTextGray,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
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

  Widget _HoverFieldWrapper({
    required Widget? child,
    required _ActiveField field,
    required bool isHovered,
    required void Function(bool) onHover,
    IconData? prefixIcon,
    String? hintText,
    FocusNode? focusNode,
    double? height = 48,
    bool isReadOnly = false,
  }) {
    final bool isActive = _activeField == field;
    final bool shouldBeActive = isActive || isHovered;

    final Color borderColor = shouldBeActive
        ? kHoverBorderColor
        : kLightBorderGray;
    final double borderWidth = shouldBeActive ? 2.0 : 1.0;
    final Color iconColor = shouldBeActive ? kDarkTextGray : kLightIconGray;

    return MouseRegion(
      cursor: SystemMouseCursors.text,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () {
          if (isReadOnly && field == _ActiveField.date) {
            setState(() {
              _isDateCalendarOpen = !_isDateCalendarOpen;
              _activeField = _isDateCalendarOpen
                  ? _ActiveField.date
                  : _ActiveField.none;
            });
          }
        },
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: focusNode != null && child == null
              ? TextFormField(
                  focusNode: focusNode,
                  readOnly: isReadOnly,
                  style: const TextStyle(color: kDarkTextGray, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: prefixIcon != null
                        ? Icon(prefixIcon, color: iconColor, size: 18)
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                )
              : child,
        ),
      ),
    );
  }

  Widget _buildFooterActionButton(String text, IconData icon) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(8.0),
        foregroundColor: kDarkTextGray,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: kLightIconGray),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField({
    required _ActiveField field,
    required String hintText,
  }) {
    const double timeFieldHeight = 48;
    return Container(
      height: timeFieldHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kLightBorderGray, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextFormField(
        readOnly: true,
        style: const TextStyle(color: kDarkTextGray, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.access_time_outlined,
            color: kLightIconGray,
            size: 18,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }

  // --- NEW: Table Calendar Widget ---
  Widget _buildTableCalendar() {
    const double calendarWidth = 460;
    const double calendarHeight = 340;

    // Positioning logic (relative to the date field)
    // The date field starts around 255px from the top of the dialog content area.
    return Positioned(
      top: 255,
      left: 20,
      child: Container(
        width: calendarWidth,
        height: calendarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            _selectDate(selectedDay); // Call the custom selection logic
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: false,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kDarkTextGray,
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: kLightIconGray),
            rightChevronIcon: Icon(Icons.chevron_right, color: kLightIconGray),
            headerPadding: const EdgeInsets.only(
              top: 10,
              bottom: 8,
              left: 0,
              right: 0,
            ),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            todayTextStyle: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
            ),
            selectedDecoration: BoxDecoration(
              color: kPrimaryBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            weekendTextStyle: const TextStyle(color: kDarkTextGray),
            defaultTextStyle: const TextStyle(color: kDarkTextGray),
            outsideDaysVisible: false, // Hides days outside the current month
            tableBorder: TableBorder.all(color: Colors.transparent),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: kDarkTextGray,
            ),
            weekendStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: kDarkTextGray,
            ),
          ),
        ),
      ),
    );
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    String formattedSelectedDate = _formatDateWithSuffix(_selectedDate);

    return SizedBox(
      width: 500,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --------------------------------- HEADER ---------------------------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Time Entry',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kDarkTextGray,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: kLightIconGray),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: kLightBorderGray),

                // --------------------------------- BODY ---------------------------------
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. Task Input
                      _buildLabel('Task', isRequired: true),
                      _HoverFieldWrapper(
                        field: _ActiveField.task,
                        isHovered: _isTaskHovered,
                        onHover: (hover) =>
                            setState(() => _isTaskHovered = hover),
                        prefixIcon: Icons.search,
                        hintText: 'Search assigned tasks...',
                        focusNode: _taskFocus,
                        child: null,
                      ),

                      // 2. Date Input (Triggers Calendar)
                      _buildLabel('Date', isRequired: true),
                      _HoverFieldWrapper(
                        field: _ActiveField.date,
                        isHovered: _isDateHovered,
                        onHover: (hover) =>
                            setState(() => _isDateHovered = hover),
                        isReadOnly: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                                color:
                                    _isDateHovered ||
                                        _activeField == _ActiveField.date
                                    ? kDarkTextGray
                                    : kLightIconGray,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  formattedSelectedDate,
                                  style: const TextStyle(
                                    color: kDarkTextGray,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: kLightIconGray,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 3. Checkbox: Use duration instead of end time
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _useDurationInstead,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _useDurationInstead = newValue!;
                                  });
                                },
                                activeColor: kPrimaryBlue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('Use duration instead of end time'),
                          ],
                        ),
                      ),

                      // 4. From Time / To Time
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel(
                                  _useDurationInstead
                                      ? 'Duration'
                                      : 'From Time',
                                  isRequired: true,
                                ),
                                _buildTimeField(
                                  field: _ActiveField.timeFrom,
                                  hintText: '--- --',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel(
                                  'To Time',
                                  isRequired: !_useDurationInstead,
                                ),
                                if (!_useDurationInstead)
                                  _buildTimeField(
                                    field: _ActiveField.timeTo,
                                    hintText: '--- --',
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // 5. Checkbox: Spans midnight (Conditional)
                      if (!_useDurationInstead)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: _spansMidnight,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _spansMidnight = newValue!;
                                    });
                                  },
                                  activeColor: kPrimaryBlue,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('Spans midnight'),
                            ],
                          ),
                        ),

                      // 6. Remark Input (Multiline)
                      _buildLabel('Remark', isRequired: true),
                      _HoverFieldWrapper(
                        field: _ActiveField.remark,
                        isHovered: false,
                        onHover: (_) {},
                        focusNode: _remarkFocus,
                        hintText: 'Describe the work performed...',
                        height: 100,
                        child: null,
                      ),

                      // 7. Justification Note (Optional/Multiline)
                      _buildLabel('Justification Note', isRequired: false),
                      _HoverFieldWrapper(
                        field: _ActiveField.justification,
                        isHovered: false,
                        onHover: (_) {},
                        focusNode: _justificationFocus,
                        hintText:
                            'Required if no desktop screenshots are available for this time period...',
                        height: 100,
                        child: null,
                      ),

                      // Footer message
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: Text(
                          'Leave blank if desktop screenshots are available for this time period',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: kLightBorderGray),

                // --------------------------------- FOOTER BUTTONS ---------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Action Buttons (Left side)
                      _buildFooterActionButton('Split Entry', Icons.call_split),
                      const SizedBox(width: 5),
                      _buildFooterActionButton(
                        'Duplicate Tomorrow',
                        Icons.copy_outlined,
                      ),
                      const SizedBox(width: 5),
                      _buildFooterActionButton(
                        'Autofill 8:00h',
                        Icons.access_time,
                      ),

                      const Spacer(),

                      // Group 2: Cancel and Primary Action Button (Right side)
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          foregroundColor: kDarkTextGray,
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 15),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Create Entry',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // --------------------------------- CALENDAR POPUP (Table Calendar) ---------------------------------
            if (_isDateCalendarOpen) _buildTableCalendar(),
          ],
        ),
      ),
    );
  }
}
