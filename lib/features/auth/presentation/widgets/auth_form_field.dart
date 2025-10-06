import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    
    // Field Customization (NEW)
    this.fieldFillColor = const Color(0xFFF5F5F5), // Default to grey.shade100 hex
    this.fieldVerticalPadding = 14.0,             // Controls the height of the input area

    // Label Style
    this.labelFontFamily,
    this.labelColor = Colors.black87,
    this.labelFontSize = 14.0,
    this.labelFontWeight = FontWeight.w500,
    
    // Input/Value Style
    this.inputFontFamily,
    this.inputColor = Colors.black, 
    this.inputFontSize = 14.0, 
    this.inputFontWeight = FontWeight.normal,
    
    // Hint Style
    this.hintFontSize = 14.0,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  // NEW Field Customization Properties
  final Color fieldFillColor;
  final double fieldVerticalPadding; 

  // Label Style Properties
  final String? labelFontFamily;
  final Color labelColor;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  
  // Input Field (Text/Value) Style Properties
  final String? inputFontFamily;
  final Color inputColor;
  final double inputFontSize;
  final FontWeight inputFontWeight;

  // Hint Style Property
  final double hintFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: TextStyle(
            fontFamily: labelFontFamily,
            fontSize: labelFontSize,
            fontWeight: labelFontWeight,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        // Input Field
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(
            fontFamily: inputFontFamily,
            fontSize: inputFontSize,
            fontWeight: inputFontWeight,
            color: inputColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: hintFontSize, 
              color: Colors.grey.shade500,
            ),
            filled: true,
            fillColor: fieldFillColor, // <<< CUSTOMIZABLE COLOR
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            // Padding controls the height of the field
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16, 
              vertical: fieldVerticalPadding, // <<< CUSTOMIZABLE PADDING/HEIGHT
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}