import 'package:flutter/material.dart';
import '../signin_screen.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsMain extends StatelessWidget {
  const SettingsMain({Key? key}) : super(key: key);

  Widget _item(BuildContext context, IconData icon, String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: const Color(0xFF33E4DB), shape: BoxShape.circle),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
            const Icon(Icons.chevron_right, color: Color(0xFF33E4DB)),
          ],
        ),
      ),
    );
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                const Text('Are you sure you want to log out?', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF00BBD3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel', style: TextStyle(color: Color(0xFF00BBD3), fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(ctx).pop();
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SignInScreen()));
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(child: Text('Yes, Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)]),
            ),
            child: SafeArea(
              child: Center(
                child: Text('SETTINGS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item(context, Icons.person_outline, 'Profile', () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                  }),

                  const Divider(),

                  _item(context, Icons.lock_outline, 'Privacy Policy', () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Privacy Policy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        content: SingleChildScrollView(
                          child: DefaultTextStyle(
                            style: const TextStyle(fontSize: 12, height: 1.3, color: Colors.black87),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Effective Date: [Insert date]\n'),
                                SizedBox(height: 6),
                                Text('This Privacy Policy explains how U-COLORPI collects, uses, and protects user information. This application is developed for academic and research purposes only and is not intended to replace professional medical diagnosis or treatment.'),
                                SizedBox(height: 8),
                                Text('1. Information We Collect\n\nWhen you create an account, the application may collect the following information:\n\nBasic account information (e.g., name, email address)\n\nUrinalysis scan results generated by the application\n\nApplication usage data for system improvement and academic evaluation'),
                                SizedBox(height: 8),
                                Text('2. Purpose of Data Collection\n\nThe collected information is used solely to:\n\n- Store and display urinalysis results based on standard reference values\n- Present scan results and record history for user review\n- Support system testing, evaluation, and documentation for this academic study\n- Improve the functionality, usability, and performance of the application'),
                                SizedBox(height: 8),
                                Text('3. Result Interpretation Disclaimer\n\nAll urinalysis results displayed in the application are reference-based and intended for informational and monitoring purposes only. The application does not provide medical diagnoses, treatment recommendations, or clinical decisions.'),
                                SizedBox(height: 8),
                                Text('4. Data Protection and Security\n\nReasonable technical and organizational measures are implemented to protect user data against unauthorized access, alteration, or disclosure. Access to stored data is limited to authorized users and researchers involved in this academic project.'),
                                SizedBox(height: 8),
                                Text('5. Data Sharing\n\nUser information is not shared with third parties. Data may only be accessed for academic evaluation and research documentation related to this study.'),
                                SizedBox(height: 8),
                                Text('6. User Consent\n\nBy creating an account and checking the consent box, you confirm that:\n\n- You have read and understood this Privacy Policy\n- You voluntarily provide your information\n- You consent to the collection and use of your data as described above'),
                                SizedBox(height: 8),
                                Text('7. Legal Compliance\n\nThis application follows the principles of the Data Privacy Act of 2012 (Republic Act No. 10173), including transparency, legitimate purpose, and proportionality.'),
                                SizedBox(height: 8),
                                Text('8. Contact Information\n\nFor questions or concerns regarding this Privacy Policy, please contact: [Insert project email or developer contact]'),
                              ],
                            ),
                          ),
                        ),
                        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
                      ),
                    );
                  }),

                  const Divider(),

                  _item(context, Icons.help_outline, 'Help', () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Help not implemented')));
                  }),

                  const Divider(),

                                    _item(context, Icons.logout, 'Logout', () {
                    _showLogoutSheet(context);
                  }),

                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
