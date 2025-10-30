import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CreateAnnouncementDialog extends StatelessWidget {
  const CreateAnnouncementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      // backgroundColor: Colors.white,
      child: const AnnouncementContent(),
    );
  }
}

class AnnouncementContent extends StatefulWidget {
  const AnnouncementContent({super.key});

  @override
  State<AnnouncementContent> createState() => _AnnouncementContentState();
}

class _AnnouncementContentState extends State<AnnouncementContent> {
  bool _publishImmediately = true;
  String? _selectedPriority = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 512,
      height: 574,
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),

          // const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Title *'),
                  _buildTextField('Enter announcement title', maxLines: 1),
                  const SizedBox(height: 16),

                  _buildLabel('Content *'),
                  _buildTextField('Enter announcement content', maxLines: 4),
                  const SizedBox(height: 16),

                  _buildLabel('Priority'),
                  _buildPriorityDropdown(),
                  const SizedBox(height: 16),

                  _buildLabel('Expiry Date (Optional)'),
                  _buildDateField('mm/dd/yyyy'),
                  const SizedBox(height: 16),

                  _buildPublishSwitch(),

                  SizedBox(height: 16),

                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 24.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Create New Announcement',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: Color(0xFF0A0A0A),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0A0A0A),
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    const Color borderColor = Color(0xFFC0C0C0);
    const Color focusColor = Colors.blue;

    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFF717182),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: const BorderSide(color: borderColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: const BorderSide(color: focusColor, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.0),
        borderSide: const BorderSide(color: borderColor, width: 1.0),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildTextField(String hint, {required int maxLines}) {
    return TextField(
      maxLines: maxLines,
      expands: maxLines > 1 ? false : false,
      decoration: _getInputDecoration(hintText: hint),
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedPriority,
      decoration: _getInputDecoration(hintText: ''),
      items: <String>['Normal', 'High', 'Urgent'].map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        },
      ).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedPriority = newValue;
        });
      },
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      isExpanded: true,
    );
  }

  Widget _buildDateField(String hintText) {
    return TextField(
      readOnly: true,
      decoration: _getInputDecoration(
        hintText: hintText,
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPublishSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Publish immediately',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: _publishImmediately,
            onChanged: (bool value) {
              setState(() {
                _publishImmediately = value;
              });
            },
            activeColor: const Color(0xFF007BFF),
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   border: Border(top: BorderSide(color: Colors.grey.shade200)),
      //   borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8.0)),
      // ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFF0F0F0),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0.0,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF0A0A0A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Create Announcement',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
