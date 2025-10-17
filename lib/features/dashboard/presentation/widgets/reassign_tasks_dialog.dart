// --- New Widget: Assignee Option Row ---
import 'package:flutter/material.dart';

class _AssigneeOption extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final String roleTag;
  final Color roleColor;

  const _AssigneeOption({
    required this.initials,
    required this.name,
    required this.role,
    required this.roleTag,
    required this.roleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          // Avatar (Circle with initials)
          CircleAvatar(
            radius: 18,
            backgroundColor: roleColor.withOpacity(
              0.2,
            ), // Light background based on role
            child: Text(
              initials,
              style: TextStyle(
                color: roleColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name and Role
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Role Tag (Small box)
                  if (roleTag.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: roleColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        roleTag,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: roleColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- The Stateful Reassign Task Modal ---
class _ReassignTaskModal extends StatefulWidget {
  const _ReassignTaskModal();
  @override
  State<_ReassignTaskModal> createState() => _ReassignTaskModalState();
}

class _ReassignTaskModalState extends State<_ReassignTaskModal> {
  // Define a simple structure for user data
  final List<Map<String, dynamic>> _assignees = const [
    {
      'id': 1,
      'name': 'Arjun Mehta',
      'initials': 'AM',
      'role': 'Staff',
      'role_tag': '',
      'role_color': Colors.blueGrey,
    },
    {
      'id': 2,
      'name': 'Sneha Gupta',
      'initials': 'SG',
      'role': 'Staff',
      'role_tag': '',
      'role_color': Colors.blueGrey,
    },
    {
      'id': 3,
      'name': 'Nisha Reddy',
      'initials': 'NR',
      'role': 'Staff',
      'role_tag': '',
      'role_color': Colors.blueGrey,
    },
    {
      'id': 4,
      'name': 'Priya Sharma',
      'initials': 'PS',
      'role': 'Staff',
      'role_tag': '',
      'role_color': Colors.blueGrey,
    },
    {
      'id': 5,
      'name': 'Rohit Verma',
      'initials': 'RV',
      'role': 'TM',
      'role_tag': 'TM',
      'role_color': Color(0xFFDD3333), // Red color for TM (Team Manager)
    },
    {
      'id': 6,
      'name': 'Anjali Patel',
      'initials': 'AP',
      'role': 'Staff',
      'role_tag': '',
      'role_color': Colors.blueGrey,
    },
    {
      'id': 7,
      'name': 'Deepak Jain',
      'initials': 'DJ', // Inferred initials
      'role': 'Staff',
      'role_tag': '',
      'role_color': Colors.blueGrey,
    },
  ];

  int? _selectedAssigneeId; // Tracks the ID of the selected assignee

  @override
  Widget build(BuildContext context) {
    // Determine the blue color for the button/selection
    const Color primaryBlue = Color(0xFF007bff);
    const Color borderColor = Color(0xFFDDDDDD);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      // constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),

      // Modal Header
      title: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reassign Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),

      // Modal Content (Assignee List)
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Select Assignees Label
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
            child: Text(
              'Select Assignees',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF424242),
              ),
            ),
          ),

          // List of Assignees
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _assignees.length,
              itemBuilder: (context, index) {
                final user = _assignees[index];
                final bool isSelected = user['id'] == _selectedAssigneeId;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAssigneeId = user['id'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        // Custom Radio Button (or use Flutter's Radio)
                        Radio<int>(
                          value: user['id'],
                          groupValue: _selectedAssigneeId,
                          onChanged: (int? id) {
                            setState(() {
                              _selectedAssigneeId = id;
                            });
                          },
                          activeColor: primaryBlue,
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return primaryBlue;
                            }
                            return Colors.grey;
                          }),
                        ),

                        // Assignee Info
                        Expanded(
                          child: _AssigneeOption(
                            initials: user['initials'],
                            name: user['name'],
                            role: user['role'],
                            roleTag: user['role_tag'],
                            roleColor: user['role_color'],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Action Buttons
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
                side: const BorderSide(color: borderColor),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _selectedAssigneeId != null
                  ? () {
                      // Log the reassignment action
                      final selectedUser = _assignees.firstWhere(
                        (u) => u['id'] == _selectedAssigneeId,
                      );
                      print('Task Reassigned to: ${selectedUser['name']}');
                      Navigator.of(context).pop();
                    }
                  : null, // Button is disabled if no assignee is selected
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                elevation: 0,
              ),
              child: const Text(
                'Reassign Task',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
