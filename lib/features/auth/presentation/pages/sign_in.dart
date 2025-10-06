import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:dna_taskflow_prime/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  void _navigateToForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Forgot Password link pressed! Implement navigation here.',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Email validation logic.
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
      return 'Please enter a valid email address';
    return null;
  }

  /// Password validation logic.
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen properties
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = context.isMobile;
    const double desktopFixedWidth = 450.0;
    const double maxCardWidth = 500.0;

    final double cardWidth = screenWidth > 600
        ? desktopFixedWidth
        : screenWidth * 0.9;

    final double finalCardWidth = cardWidth.clamp(300.0, maxCardWidth);

    final Color primaryAppBlue = Colors.blue.shade800;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            // Use the calculated width for responsiveness
            width: finalCardWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // --- Logo Section ---
                Image.asset(
                  'lib/assets/Logo.png',
                  height: context.scaleFont(40),
                  errorBuilder: (context, error, stackTrace) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'dnA',
                          style: TextStyle(
                            fontSize: context.scaleFont(32),
                            fontWeight: FontWeight.w900,
                            color: primaryAppBlue,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.trending_up,
                          color: Colors.green.shade500,
                          size: context.scaleFont(32),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),

                // Application Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: primaryAppBlue,
                      size: context.scaleFont(24),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'TimeTracker Pro',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: context.scaleFont(22),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                // Slogan/Tagline
                Text(
                  'Professional timesheet management with advanced analytics',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    fontSize: context.scaleFont(14),
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 40),

                // --- Sign In Form Card ---
                Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Use a slightly softer border color for web feel
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Padding(
                    // Increase padding slightly for larger screens
                    padding: EdgeInsets.all(isMobile ? 24.0 : 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome Text
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: context.scaleFont(24),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Sign in to your account',
                                  style: TextStyle(
                                    fontSize: context.scaleFont(16),
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Email Field
                          AuthFormField(
                            label: 'Email',
                            hintText: 'Enter your email',
                            controller: _emailController,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            labelFontFamily: 'Inter',
                            labelFontSize: context.scaleFont(14),
                            labelFontWeight: FontWeight.w500,
                            inputFontFamily: 'Inter',
                            inputFontWeight: FontWeight.normal,
                            inputFontSize: context.scaleFont(14),
                            hintFontSize: context.scaleFont(14),
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          AuthFormField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            controller: _passwordController,
                            validator: _validatePassword,
                            obscureText: !_isPasswordVisible,
                            labelFontFamily: 'Inter',
                            labelFontSize: context.scaleFont(14),
                            labelFontWeight: FontWeight.w500,
                            inputFontFamily: 'Inter',
                            inputFontWeight: FontWeight.normal,
                            inputFontSize: context.scaleFont(14),
                            hintFontSize: context.scaleFont(14),
                            fieldVerticalPadding: 14.0,
                            fieldFillColor: Colors.grey.shade100,

                            // Password Visibility Toggle
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey.shade500,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),

                          // Forgot Password Link
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _navigateToForgotPassword,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(1, 1),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: context.scaleFont(13),
                                  fontWeight: FontWeight.w500,
                                  color: primaryAppBlue,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: CustomElevatedButton(
                              text: 'Sign In',
                              onPressed: _signIn,
                              fontSize: context.scaleFont(14),
                              fontWeight: FontWeight.w500,
                              foregroundColor: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
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
