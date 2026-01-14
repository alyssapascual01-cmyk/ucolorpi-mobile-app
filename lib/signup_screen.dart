import 'package:flutter/material.dart';
import 'healthbackground_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? sexValue;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primary1 = const Color(0xFF00BBD3);
    final primary2 = const Color(0xFF33E4DB);
    final fieldFill = const Color(0xFFEFFCFB);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)],
              ),
            ),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'New Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  const Text('Full name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      hintText: 'Alyssa Smith',
                      hintStyle: const TextStyle(color: Color(0xFF88D6D9)),
                      filled: true,
                      fillColor: fieldFill,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text('Date Of Birth', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: dobController,
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(1990, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        dobController.text = '${picked.day.toString().padLeft(2, '0')} / ${picked.month.toString().padLeft(2, '0')} / ${picked.year}';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'DD / MM /YYYY',
                      hintStyle: const TextStyle(color: Color(0xFF88D6D9)),
                      filled: true,
                      fillColor: fieldFill,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text('Sex', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: fieldFill,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: sexValue,
                      onChanged: (v) => setState(() => sexValue = v),
                      decoration: const InputDecoration(border: InputBorder.none),
                      items: ['female', 'male', 'other'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text('Email', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      hintStyle: const TextStyle(color: Color(0xFF88D6D9)),
                      filled: true,
                      fillColor: fieldFill,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text('Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: '***************',
                      hintStyle: const TextStyle(color: Color(0xFF88D6D9)),
                      filled: true,
                      fillColor: fieldFill,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text('Confirm Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: confirmController,
                    obscureText: _obscureConfirm,
                    decoration: InputDecoration(
                      hintText: '***************',
                      hintStyle: const TextStyle(color: Color(0xFF88D6D9)),
                      filled: true,
                      fillColor: fieldFill,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                    ),
                  ),

                  const SizedBox(height: 18),
                  const Center(
                    child: Text(
                      'By continuing, you agree to\nTerms of Use and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {
                      final fullName = fullNameController.text.trim();
                      final dob = dobController.text.trim();
                      final sex = sexValue;
                      final email = emailController.text.trim();
                      final password = passwordController.text;
                      final confirm = confirmController.text;

                      if (fullName.isEmpty || dob.isEmpty || sex == null || email.isEmpty || password.isEmpty || confirm.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
                        return;
                      }

                      if (password != confirm) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
                        return;
                      }

                      final profile = {
                        'fullName': fullName,
                        'dateOfBirth': dob,
                        'sex': sex,
                        'email': email,
                        'password': password,
                      };

                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HealthBackgroundScreen(profile: profile)));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [primary2, primary1]),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [BoxShadow(color: primary1.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 6))],
                      ),
                      child: const Center(
                        child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('already have an account? ', style: TextStyle(color: Colors.black54)),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Log in', style: TextStyle(color: Color(0xFF00BBD3))),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}
