import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

enum SettingsTab { day_view, week_view, month_view }

const Color kPrimaryBlue = Color(0xFF007bff);
const Color kAccentGreen = Color(0xFF4CAF50);
const Color kLightGray = Color(0xFFF7F7F7);
const Color kBorderColor = Color(0xFFD6D6D6);
const Color kWarningYellow = Color(0xFFFFF3CD);
const Color kWarningOrange = Color(0xFFFEE8D3);
const double kBorderRadius = 6.0;

class InteractiveButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final bool isSelected;
  final Color baseColor;
  final Color hoverColor;
  final VoidCallback? onTap;
  final bool compact;

  const InteractiveButton({
    super.key,
    required this.text,
    this.icon,
    this.isSelected = false,
    this.baseColor = Colors.black87,
    this.hoverColor = kPrimaryBlue,
    this.onTap,
    this.compact = false,
  });

  @override
  State<InteractiveButton> createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton> {
  bool _isHovering = false;

  void _handleHover(bool hover) {
    setState(() {
      _isHovering = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.isSelected || _isHovering;

    final Color effectiveBgColor = widget.isSelected
        ? widget.hoverColor
        : (widget.compact && _isHovering
              ? widget.hoverColor.withOpacity(0.1)
              : (_isHovering
                    ? widget.hoverColor.withOpacity(0.1)
                    : Colors.white));

    final Color effectiveBorderColor = isActive
        ? widget.hoverColor
        : kBorderColor;
    final Color effectiveColor = widget.isSelected
        ? Colors.white
        : (isActive ? widget.hoverColor : widget.baseColor);

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: effectiveBgColor,
            borderRadius: BorderRadius.circular(kBorderRadius),
            border: Border.all(color: effectiveBorderColor, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(widget.icon, size: 16, color: effectiveColor),
                ),
              Text(
                widget.text,
                style: TextStyle(
                  color: effectiveColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  final String hintText;
  final double width;

  const SearchInput({super.key, required this.hintText, this.width = 00});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: widget.width,
      constraints: BoxConstraints(maxWidth: widget.width),
      child: TextFormField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          prefixIcon: const Icon(Icons.search, color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
          ),
        ),
      ),
    );
  }
}

class DropdownItem extends StatefulWidget {
  final String text;
  const DropdownItem({super.key, required this.text});

  @override
  State<DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: _isHovering ? kAccentGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isHovering ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class InteractiveDropdown extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> options;
  final String currentValue;
  final ValueChanged<String> onChanged;

  const InteractiveDropdown({
    super.key,
    required this.title,
    required this.icon,
    required this.options,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        border: Border.all(color: kBorderColor),
      ),
      child: PopupMenuButton<String>(
        initialValue: currentValue,
        onSelected: onChanged,
        padding: EdgeInsets.zero,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          side: const BorderSide(color: kPrimaryBlue),
        ),
        itemBuilder: (BuildContext context) {
          return options.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              padding: EdgeInsets.zero,
              child: DropdownItem(text: choice),
            );
          }).toList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 4),
              Text(
                currentValue,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String text;
  final Color color;
  final Color bgColor;

  const Tag({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.bgColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class TimesheetEntryCard extends StatelessWidget {
  final String title;
  final String client;
  final String timeRange;
  final String duration;
  final String coverage;
  final String estTime;
  final String variance;
  final String entryMethod;
  final String remark;
  final String? justification;
  final String status;

  const TimesheetEntryCard({
    super.key,
    required this.title,
    required this.client,
    required this.timeRange,
    required this.duration,
    required this.coverage,
    required this.estTime,
    required this.variance,
    required this.entryMethod,
    required this.remark,
    this.justification,
    required this.status,
  });

  Widget _buildTimeDetails(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.schedule, size: 16, color: Colors.black54),
        SizedBox(width: 4),
        Text(
          '$timeRange ($duration)',
          style: TextStyle(color: Colors.black87, fontSize: 13),
        ),
        SizedBox(width: 20),
        Icon(Icons.check_circle_outline, size: 16, color: kAccentGreen),
        SizedBox(width: 4),
        Text(
          'Coverage: $coverage',
          style: TextStyle(
            color: kAccentGreen,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 20),
        Text(
          'Est: $estTime',
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        SizedBox(width: 10),
        if (variance.isNotEmpty)
          Tag(text: variance, color: Colors.white, bgColor: Colors.red[600]!),
        SizedBox(width: 20),
        Text(
          entryMethod,
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildRemarkSection(String label, String content, {Color? bgColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: bgColor ?? kLightGray,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: RichText(
        text: TextSpan(
          // style: DefaultTextStyle.of(context).style.copyWith(fontSize: 13),
          children: <TextSpan>[
            TextSpan(
              text: '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextSpan(
              text: ' $content',
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius * 2),
        border: Border.all(color: kBorderColor.withOpacity(0.5)),
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
        children: [
          // Title, Status, Action Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 10),
                  // Status Tag
                  Tag(
                    text: status,
                    color: status == 'Draft' ? Colors.black54 : Colors.orange,
                    bgColor: status == 'Pending TM'
                        ? Colors.orange.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.edit_outlined, size: 18, color: Colors.black54),
                  SizedBox(width: 10),
                  Icon(Icons.more_vert, size: 18, color: Colors.black54),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(client, style: TextStyle(fontSize: 14, color: Colors.black54)),
          SizedBox(height: 10),

          // Time Details Row
          _buildTimeDetails(context),
          SizedBox(height: 10),

          // Remark Section
          _buildRemarkSection('Remark', remark),

          // Justification Section (if exists)
          if (justification != null)
            _buildRemarkSection(
              'Justification',
              justification!,
              bgColor: kWarningOrange.withOpacity(0.6),
            ),
        ],
      ),
    );
  }
}

// --- MAIN SCREEN LAYOUT (Focuses on Timesheet Content) ---

class TimeSheetPage extends StatefulWidget {
  const TimeSheetPage({super.key});

  @override
  State<TimeSheetPage> createState() => _TimeSheetPageState();
}

class _TimeSheetPageState extends State<TimeSheetPage> {
  // String _selectedView = 'Day View';
  String _selectedDateRange = 'Today';
  String _selectedGrouping = 'No Grouping';
  SettingsTab _selectedTab = SettingsTab.day_view;

  String _getTabName(SettingsTab tab) {
    switch (tab) {
      case SettingsTab.day_view:
        return 'Day View';
      case SettingsTab.week_view:
        return 'Week View';
      case SettingsTab.month_view:
        return 'Month View';
    }
  }

  final List<String> dateOptions = [
    'Today',
    'This Week',
    'Last 7 Days',
    'This Month',
    'Last Month',
    'Custom Range',
  ];

  final List<String> groupingOptions = [
    'No Grouping',
    'By Client',
    'By Project',
    'By Task',
  ];

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: SettingsTab.values.map((tab) {
          final isSelected = _selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                _getTabName(tab),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedTab = tab;
                  });
                }
              },
              showCheckmark: false,

              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              // backgroundColor: isSelected
              //     ? AppColors.primaryDark
              //     : const Color(0xFFFFFFFF),
              backgroundColor: const Color(0xFFFFFFFF),
              selectedColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color(0xFFFFFFFF)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Advanced Timesheet',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Track, filter, and analyze your time entries with advanced controls',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InteractiveButton(
                      text: 'Bulk Import',
                      icon: Icons.upload_file,
                      // baseColor: kPrimaryBlue,
                      // hoverColor: kPrimaryBlue,
                      onTap: () => {},
                    ),
                    const SizedBox(width: 10),
                    // Export Button (Standard Button)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        border: Border.all(color: kBorderColor, width: 1),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.download, size: 16, color: Colors.black87),
                          SizedBox(width: 4),
                          Text(
                            'Export',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- ROW 2: Search and Filter Dropdowns ---
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                const SearchInput(
                  hintText: 'Search tasks, clients, remarks...',
                  width: 652,
                ),

                // 3. Dropdowns (Today, All Clients, All Tasks, All Status)
                InteractiveDropdown(
                  title: 'Today',
                  icon: Icons.calendar_today_outlined,
                  options: dateOptions,
                  currentValue: _selectedDateRange,
                  onChanged: (val) => setState(() => _selectedDateRange = val),
                ),
                const InteractiveDropdown(
                  title: 'All Clients',
                  icon: Icons.person_outline,
                  options: ['Client A', 'Client B'],
                  currentValue: 'All Clients',
                  onChanged: print,
                ),
                const InteractiveDropdown(
                  title: 'All Tasks',
                  icon: Icons.folder_outlined,
                  options: ['Task 1', 'Task 2'],
                  currentValue: 'All Tasks',
                  onChanged: print,
                ),
                const InteractiveDropdown(
                  title: 'All Status',
                  icon: Icons.check_circle_outline,
                  options: ['Draft', 'Approved'],
                  currentValue: 'All Status',
                  onChanged: print,
                ),
              ],
            ),
            const SizedBox(height: 15),

            // --- ROW 3: Quick Filters ---
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Quick filters:',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(width: 10),
                // 4. Quick Filter Buttons
                InteractiveButton(
                  text: 'Drafts',
                  // hoverColor: Colors.black,
                  // baseColor: Colors.black87,
                  compact: true,
                ),
                InteractiveButton(
                  text: 'Pending Approval',
                  // hoverColor: Colors.amber,
                  // baseColor: Colors.black87,
                  compact: true,
                ),
                InteractiveButton(
                  text: 'Overtime',
                  // hoverColor: Colors.red,
                  // baseColor: Colors.black87,
                  compact: true,
                ),
                InteractiveButton(
                  text: 'Low Coverage',
                  // hoverColor: Colors.orange,
                  // baseColor: Colors.black87,
                  compact: true,
                ),
                InteractiveButton(
                  text: 'More Filters',
                  icon: Icons.filter_list,
                  compact: true,
                ),
              ],
            ),

            const SizedBox(height: 20),
            InteractiveButton(
              text: 'Save View',
              icon: Icons.bookmark_border,
              // baseColor: kPrimaryBlue,
              // hoverColor: kPrimaryBlue,
              onTap: () => print('Save View tapped'),
              compact: true,
            ),
            const Divider(),
            const SizedBox(height: 20),

            // --- ROW 4: Save View, View Tabs, Grouping Dropdown ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 6. View Tab Bar
                    Row(
                      children: [
                        const Text(
                          'View:',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        _buildTabBar(),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Text(
                      'Group by:',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    // 7. No Grouping Dropdown
                    InteractiveDropdown(
                      title: 'No Grouping',
                      icon: Icons.apps_outlined,
                      options: groupingOptions,
                      currentValue: _selectedGrouping,
                      onChanged: (val) =>
                          setState(() => _selectedGrouping = val),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- ROW 5: Sort Options ---
            Row(
              children: [
                const Text(
                  'Sort:',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(width: 10),
                // 8. Sort Buttons (Date, Hours, Variance)
                InteractiveButton(
                  text: 'Date',
                  icon: Icons.arrow_upward,
                  baseColor: kPrimaryBlue,
                  hoverColor: kPrimaryBlue,
                  isSelected: true,
                ),
                InteractiveButton(
                  text: 'Hours',
                  icon: Icons.schedule,
                  baseColor: Colors.black54,
                  hoverColor: kPrimaryBlue,
                ),
                InteractiveButton(
                  text: 'Variance',
                  icon: Icons.swap_vert,
                  baseColor: Colors.black54,
                  hoverColor: kPrimaryBlue,
                ),
                InteractiveButton(
                  text: 'More sorts',
                  icon: Icons.add,
                  baseColor: Colors.black54,
                  hoverColor: kPrimaryBlue,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- SUMMARY CARDS ---
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SummaryCard(
                  title: "Today's Total",
                  value: "7.5h",
                  icon: Icons.schedule,
                  subtitle: '',
                ),
                SummaryCard(
                  title: "Week Total",
                  value: "37.5h",
                  icon: Icons.calendar_view_week,
                  subtitle: 'Partial',
                ),
                SummaryCard(
                  title: "Pending Approval",
                  value: "3",
                  icon: Icons.check_circle_outline,
                  subtitle: 'Action Required',
                ),
                SummaryCard(
                  title: "Entry Method",
                  value: "Manual Only",
                  icon: Icons.input,
                  subtitle: '',
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- TIMESHEET ENTRIES (Screenshot 2) ---

            // Warning Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kWarningYellow,
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    size: 20,
                    color: Colors.amber.shade700,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Day total: 7:30 - Under 8 hours (0:30 remaining)',
                    style: TextStyle(
                      color: Colors.amber.shade900,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Sample Entry 1
            const TimesheetEntryCard(
              title: 'GSTR-1 Filing for Acme Corp',
              client: 'Acme Corporation',
              timeRange: '09:00 - 13:00',
              duration: '4:00',
              coverage: '85%',
              estTime: '4h',
              variance: '',
              entryMethod: 'Manual',
              remark:
                  'Completed input tax credit reconciliation and filed GSTR-1 return',
              status: 'Draft',
            ),

            // Sample Entry 2
            const TimesheetEntryCard(
              title: 'TDS Compliance Check',
              client: 'Manufacturing Co',
              timeRange: '14:00 - 17:30',
              duration: '3:30',
              coverage: '0%',
              estTime: '3h',
              variance: '+30min',
              entryMethod: 'Manual',
              remark:
                  'Reviewed TDS compliance documentation and prepared compliance report',
              justification:
                  'Client meeting - no desktop work during this period',
              status: 'Pending TM',
            ),

            const SizedBox(height: 20),

            // Day Total Footer
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(color: kBorderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Day Total',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '7:30 (0:30 remaining)',
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 9. Add Entry Button (in Floating Action Button style for persistence)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => print('Add Entry tapped'),
        backgroundColor: kPrimaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Entry',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

/// Simple Card for Summary Section
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String subtitle;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kLightGray,
          borderRadius: BorderRadius.circular(kBorderRadius * 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: (subtitle == 'Action Required'
                                ? Colors.red
                                : Colors.black54),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Icon(icon, size: 40, color: kPrimaryBlue.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }
}
