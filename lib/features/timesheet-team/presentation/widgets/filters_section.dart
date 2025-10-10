import 'package:flutter/material.dart';

class DropdownItem {
  final String label;
  final String value;

  const DropdownItem(this.label, this.value);
}

class CustomDropdownMenu extends StatefulWidget {
  final String label;
  final String? initialValue;
  final List<DropdownItem> items;
  final ValueChanged<String>? onChanged;

  const CustomDropdownMenu({
    super.key,
    required this.label,
    required this.initialValue,
    required this.items,
    this.onChanged,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  Widget _buildCustomMenuItem(DropdownItem item) {
    final bool isSelected = item.value == _selectedValue;
    final Color backgroundColor = isSelected
        ? Colors.green.shade600
        : Colors.white;
    final Color textColor = isSelected ? Colors.white : Colors.black;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.label, style: TextStyle(color: textColor, fontSize: 14)),
          if (isSelected)
            const Icon(Icons.check, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0A),
              ),
            ),
          ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC7C7CC), width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFFC7C7CC),
              ),

              selectedItemBuilder: (BuildContext context) {
                return widget.items.map<Widget>((DropdownItem item) {
                  if (item.value != _selectedValue) return Container();
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.label,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  );
                }).toList();
              },

              items: widget.items.map((DropdownItem item) {
                return DropdownMenuItem<String>(
                  value: item.value,
                  child: _buildCustomMenuItem(item),
                );
              }).toList(),

              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                  widget.onChanged?.call(newValue);
                }
              },

              dropdownColor: Colors.white,

              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildActionButton(String text) {
  const Color borderColor = Color(0xFFC7C7CC);
  const Color backgroundColor = Color(0xFFFFFFFF);
  const Color textColor = Color(0xFF0A0A0A);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
    ),
  );
}

Widget buildTeamFilterSection() {
  const List<DropdownItem> teamItems = [
    DropdownItem('All Teams', 'all_teams'),
    DropdownItem('Team Alpha', 'team_alpha'),
    DropdownItem('Team Beta', 'team_beta'),
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          spreadRadius: 1,
          blurRadius: 2,
        ),
      ],
    ),
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0, top: 28),
          child: Text(
            'Team:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0A0A0A),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: CustomDropdownMenu(
            label: '',
            initialValue: teamItems.first.value,
            items: teamItems,
          ),
        ),
      ],
    ),
  );
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  double spacing = 16.0;
  Map<String, dynamic> selectedFilters = {};

  List<DropdownItem> dateRangeItems = [
    DropdownItem('Today', 'today'),
    DropdownItem('This Week', 'this_week'),
    DropdownItem('Last 7 Days', 'last_7_days'),
    DropdownItem('This Month', 'this_month'),
    DropdownItem('Last Month', 'last_month'),
    DropdownItem('Custom Range', 'custom_range'),
  ];

  List<DropdownItem> teamsItems = [
    DropdownItem('Select teams', 'select_teams'),
    DropdownItem('Development Team', 'development_team'),
    DropdownItem('QA Team', 'qa_team'),
    DropdownItem('Design Team', 'design_team'),
  ];

  List<DropdownItem> staffItems = [
    DropdownItem('Select staff', 'select_staff'),
    DropdownItem('John Doe', 'john_doe'),
    DropdownItem('Jane Smith', 'jane_smith'),
    DropdownItem('Alex Brown', 'alex_brown'),
  ];

  List<DropdownItem> clientsItems = [
    DropdownItem('Select clients', 'select_clients'),
    DropdownItem('Client A Corp', 'client_a'),
    DropdownItem('Client B Inc', 'client_b'),
    DropdownItem('Client C Ltd', 'client_c'),
  ];

  List<DropdownItem> statusItems = [
    DropdownItem('Status (All)', 'status_all'),
    DropdownItem('Open', 'status_open'),
    DropdownItem('In Progress', 'status_in_progress'),
    DropdownItem('Closed', 'status_closed'),
  ];

  List<DropdownItem> sourceItems = [
    DropdownItem('Source (All)', 'source_all'),
    DropdownItem('Web', 'source_web'),
    DropdownItem('Mobile', 'source_mobile'),
    DropdownItem('API', 'source_api'),
  ];

  List<DropdownItem> coverageItems = [
    DropdownItem('Coverage (All)', 'coverage_all'),
    DropdownItem('Full', 'coverage_full'),
    DropdownItem('Partial', 'coverage_partial'),
    DropdownItem('None', 'coverage_none'),
  ];

  List<DropdownItem> employmentItems = [
    DropdownItem('Status (All)', 'employment_all'),
    DropdownItem('Full-Time', 'employment_ft'),
    DropdownItem('Part-Time', 'employment_pt'),
    DropdownItem('Contractor', 'employment_contractor'),
  ];

  String? selectedDateRange;
  String? selectedTeams;
  String? selectedClient;
  String? selectedSource;
  String? selectedStaff;
  String? selectedStatus;
  String? selectedCoverage;
  String? selectedEmployement;

  addOrUpdate(String key, String value) {
    selectedFilters[key] = value;
  }

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> filterEntries = selectedFilters
        .entries
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTeamFilterSection(),
        const SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(spacing),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Date Range',
                      initialValue: selectedDateRange,
                      items: dateRangeItems,
                      onChanged: (value) {
                        setState(() {
                          selectedDateRange = value;
                          addOrUpdate('Date Range', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Teams',
                      initialValue: selectedTeams,
                      items: teamsItems,
                      onChanged: (value) {
                        setState(() {
                          selectedTeams = value;
                          addOrUpdate('Teams', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Staff',
                      initialValue: selectedStaff,
                      items: staffItems,
                      onChanged: (value) {
                        setState(() {
                          selectedStaff = value;
                          addOrUpdate('Staff', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Clients',
                      initialValue: selectedClient,

                      items: clientsItems,
                      onChanged: (value) {
                        setState(() {
                          selectedClient = value;
                          addOrUpdate('Clients', value);
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spacing),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Status',
                      initialValue: statusItems.first.value,
                      items: statusItems,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                          addOrUpdate('Status', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Source',
                      initialValue: selectedSource,
                      items: sourceItems,
                      onChanged: (value) {
                        setState(() {
                          selectedSource = value;
                          addOrUpdate('Source', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Coverage',
                      initialValue: selectedCoverage,
                      items: coverageItems,
                      onChanged: (value) {
                        setState(() {
                          selectedCoverage = value;
                          addOrUpdate('Coverage', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: CustomDropdownMenu(
                      label: 'Employment',
                      initialValue: selectedEmployement,
                      items: employmentItems,
                      onChanged: (value) {
                        setState(() {
                          selectedEmployement = value;
                          addOrUpdate('Employment', value);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spacing),
                  _buildActionButton('Overtime'),
                  const SizedBox(width: 8),
                  _buildActionButton('Shortfall'),
                ],
              ),
            ],
          ),
        ),

        if (filterEntries.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterEntries.length,
              itemBuilder: (context, index) {
                final MapEntry<String, dynamic> entry = filterEntries[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text("${entry.key} : ${entry.value}"),
                );
              },
            ),
          ),
      ],
    );
  }
}
