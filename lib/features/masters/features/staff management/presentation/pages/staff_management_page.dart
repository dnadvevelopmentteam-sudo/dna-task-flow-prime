import 'package:dna_taskflow_prime/features/masters/features/staff%20management/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

const Color kDefaultBreadcrumbColor = Color(0xFF4A5565);
const Color kHoverBlueColor = Color(0xFF3B82F6);
const Color kDividerColor = Color(0xFFD9D9D9);

class _BackButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _BackButton({required this.onPressed});

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color color = _isHovering ? kHoverBlueColor : kDefaultBreadcrumbColor;

    return InkWell(
      onTap: widget.onPressed,
      onHover: (hover) {
        setState(() {
          _isHovering = hover;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeIcon extends StatefulWidget {
  final VoidCallback onPressed;
  const HomeIcon({super.key, required this.onPressed});

  @override
  State<HomeIcon> createState() => HomeIconState();
}

class HomeIconState extends State<HomeIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (hover) {
        setState(() {
          _isHovering = hover;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Icon(
          Icons.home_outlined,
          size: 18,
          color: _isHovering ? kHoverBlueColor : kDefaultBreadcrumbColor,
        ),
      ),
    );
  }
}

// Widget for the 'Masters' Text with Hover effect
class MastersBreadcrumbItem extends StatefulWidget {
  final VoidCallback onPressed;
  const MastersBreadcrumbItem({super.key, required this.onPressed});

  @override
  State<MastersBreadcrumbItem> createState() => MastersBreadcrumbItemState();
}

class MastersBreadcrumbItemState extends State<MastersBreadcrumbItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color color = _isHovering ? kHoverBlueColor : kDefaultBreadcrumbColor;

    return InkWell(
      onTap: widget.onPressed,
      onHover: (hover) {
        setState(() {
          _isHovering = hover;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          'Masters',
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Full Custom AppBar to structure the navigation (Requirement 2)

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      // Apply the new Custom AppBar
      appBar: const CustomAppBar(currentScreen: "Staff Management"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Staff Management Header
            const StaffManagementHeader(),
            const SizedBox(height: 24),

            // Filters Section
            const FiltersCard(),
            const SizedBox(height: 24),

            // Staff Members Section
            const StaffMembersCard(),
          ],
        ),
      ),
    );
  }
}

// --- Custom Widgets for Staff Management Screen (Unchanged) ---

class StaffManagementHeader extends StatelessWidget {
  const StaffManagementHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.people_alt, color: Colors.blue, size: 32),
                SizedBox(width: 8),
                Text(
                  'Staff Management',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Manage user accounts, roles, and permissions',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 20),
          label: const Text('Add Staff Member'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }
}

class FiltersCard extends StatelessWidget {
  const FiltersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.black12, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              children: const <Widget>[
                // Search Field
                Expanded(
                  child: FilterInputField(
                    title: 'Search',
                    hintText: 'Search by name or email..',
                    icon: Icons.search,
                  ),
                ),
                SizedBox(width: 24),
                // Role Dropdown
                Expanded(
                  child: FilterDropdownField(
                    title: 'Role',
                    defaultValue: 'All Roles',
                  ),
                ),
                SizedBox(width: 24),
                // Department Dropdown
                Expanded(
                  child: FilterDropdownField(
                    title: 'Department',
                    defaultValue: 'All Departments',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FilterInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;

  const FilterInputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.black26),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.black26),
            ),
            prefixIcon: Icon(icon, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class FilterDropdownField extends StatelessWidget {
  final String title;
  final String defaultValue;

  const FilterDropdownField({
    super.key,
    required this.title,
    required this.defaultValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 44, // Approximate height for alignment with TextFormField
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: defaultValue,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              style: const TextStyle(color: Colors.black, fontSize: 16),
              items: <String>[defaultValue, 'Option 1', 'Option 2']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
              onChanged: (String? newValue) {
                // Handle dropdown change
              },
            ),
          ),
        ),
      ],
    );
  }
}

class StaffMembersCard extends StatelessWidget {
  const StaffMembersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header and Count
          Padding(
            padding: const EdgeInsets.all(24.0).copyWith(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Staff Members',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // FFEFF1F7
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '0 members',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[50], // Very light background for header row
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Expanded(flex: 3, child: TableHeader(text: 'Name')),
                Expanded(flex: 4, child: TableHeader(text: 'Email')),
                Expanded(flex: 3, child: TableHeader(text: 'Designation')),
                Expanded(flex: 2, child: TableHeader(text: 'Roles')),
                Expanded(
                  flex: 3,
                  child: TableHeader(text: 'Reporting Managers'),
                ),
                Expanded(flex: 2, child: TableHeader(text: 'Created')),
                Expanded(flex: 2, child: TableHeader(text: 'Actions')),
              ],
            ),
          ),

          // No Staff Members Message
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 48.0),
            child: Center(
              child: Text(
                'No staff members found matching your criteria.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  final String text;
  const TableHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black87,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
