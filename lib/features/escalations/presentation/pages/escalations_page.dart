import 'package:flutter/material.dart';

class EscalationsScreen extends StatefulWidget {
  const EscalationsScreen({super.key});

  @override
  State<EscalationsScreen> createState() => _EscalationsScreenState();
}

class _EscalationsScreenState extends State<EscalationsScreen> {
  final List<String> statuses = ['All statuses', 'Open', 'Closed'];
  final List<String> severities = [
    'All severities',
    'Critical',
    'High',
    'Medium',
    'Low',
  ];

  String? selectedStatus = 'All statuses';
  String? selectedSeverity = 'All severities';
  int selectedTabIndex = 0;

  Widget _buildTabItem(String title, int count, int index) {
    bool isSelected = selectedTabIndex == index;
    bool isAllTab = title == "All";

    return InkWell(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: isSelected
              ? Border(
                  bottom: BorderSide(
                    color: isAllTab ? Colors.grey.shade700 : Colors.blue,
                    width: 2.5,
                  ),
                )
              : null,
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 8),
            if (count > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Text(
                count.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown({
    required List<String> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 200,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          isExpanded: true,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: Colors.deepOrange,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Escalations',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Track and manage task blockers and issues',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_download_outlined, size: 20),
                  label: const Text('Export', style: TextStyle(fontSize: 16)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,

                    backgroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                    side: BorderSide(color: Colors.grey.shade300, width: 1.0),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters & Search',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search escalations...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildFilterDropdown(
                        items: statuses,
                        selectedValue: selectedStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue;
                          });
                        },
                      ),
                      const SizedBox(width: 16),

                      _buildFilterDropdown(
                        items: severities,
                        selectedValue: selectedSeverity,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSeverity = newValue;
                          });
                        },
                      ),
                      const SizedBox(width: 16),

                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'All statuses';
                            selectedSeverity = 'All severities';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          backgroundColor: Colors.white,
                          minimumSize: const Size(120, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Clear Filters'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                children: <Widget>[
                  _buildTabItem('All', 0, 0),
                  _buildTabItem('Open', 0, 1),
                  _buildTabItem('Critical', 0, 2),
                  _buildTabItem('Overdue', 0, 3),
                  const Spacer(),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Escalations List',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text('0 Items', style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: const <Widget>[
                        Expanded(flex: 1, child: _TableHeader('ID')),
                        Expanded(flex: 2, child: _TableHeader('Task')),
                        Expanded(flex: 2, child: _TableHeader('Severity')),
                        Expanded(flex: 2, child: _TableHeader('Status')),
                        Expanded(flex: 2, child: _TableHeader('Category')),
                        Expanded(flex: 2, child: _TableHeader('Needed By')),
                        Expanded(flex: 1, child: _TableHeader('Age')),
                        Expanded(flex: 1, child: _TableHeader('Actions')),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'No escalations found matching the current filters.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
        fontSize: 14,
      ),
      textAlign: TextAlign.start,
    );
  }
}
