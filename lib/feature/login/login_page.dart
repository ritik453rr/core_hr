import 'package:flutter/material.dart';

// Color palette extracted from the new design
const Color appBgColor = Color(0xFFF4F5F7);
const Color whiteColor = Color(0xFFFFFFFF);
const Color primaryBlue = Color(0xFF003E99); // Darker blue for button and links
const Color textDark = Color(0xFF111827); // Very dark grey/black for headings
const Color textMediumGrey = Color(0xFF4B5563); // For subtitles and regular text
const Color textLightGrey = Color(0xFF6B7280); // For placeholders and borders
const Color borderGrey = Color(0xFFCBD5E1); // Light border for the main card and inputs
const Color buttonBgGrey = Color(0xFFF3F4F6); // Background for biometrics button
const Color pillBgGrey = Color(0xFFE5E7EB); // Background for the status pill
const Color greenStatus = Color(0xFF22C55E); // Green dot color

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Top Logo ---
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderGrey.withOpacity(0.5), width: 1),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF38BDF8),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF38BDF8),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E3A8A),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // --- Welcome Text ---
                const Center(
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Sign in to sync your professional life',
                    style: TextStyle(
                      color: textMediumGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // --- Main Form Container ---
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderGrey, width: 1),
                  ),
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // -- Email Field --
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          color: textMediumGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        style: const TextStyle(color: textDark, fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'name@company.com',
                          hintStyle: const TextStyle(color: textLightGrey, fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.mail_outline, color: textLightGrey, size: 22),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: borderGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // -- Password Field Label & Link --
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Password',
                            style: TextStyle(
                              color: textMediumGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // -- Password Field Input --
                      TextField(
                        obscureText: true,
                        style: const TextStyle(color: textDark, fontSize: 15, letterSpacing: 2),
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: const TextStyle(color: textLightGrey, letterSpacing: 2),
                          prefixIcon: const Icon(Icons.lock_outline, color: textLightGrey, size: 22),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility_outlined, color: textLightGrey, size: 22),
                            onPressed: () {},
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: borderGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // -- Login Button --
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Login',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // -- Divider Line --
                      Row(
                        children: const [
                          Expanded(child: Divider(color: borderGrey, thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR CONTINUE WITH',
                              style: TextStyle(
                                  color: textLightGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: borderGrey, thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // -- Biometrics Button --
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: buttonBgGrey,
                          side: const BorderSide(color: borderGrey, width: 1),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.fingerprint, color: primaryBlue, size: 22),
                            SizedBox(width: 12),
                            Text(
                              'Login with Biometrics',
                              style: TextStyle(color: textDark, fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // --- Footer Text & Link ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: textMediumGrey, fontSize: 15),
                    ),
                    Text(
                      "Contact HR",
                      style: TextStyle(color: primaryBlue, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // --- System Status Pill ---
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: pillBgGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, color: greenStatus, size: 10),
                        SizedBox(width: 8),
                        Text(
                          'System fully operational',
                          style: TextStyle(color: textMediumGrey, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}