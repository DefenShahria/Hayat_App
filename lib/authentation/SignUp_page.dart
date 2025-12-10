import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SignIn_page.dart';
import 'auth_controller/signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedBloodGroup;
  String? _selectedDistrict;
  String? _selectedCity;

  final Map<String, List<String>> _locationData = {
    'Dhaka': ['Dhaka', 'Gazipur', 'Narayanganj'],
    'Chittagong': ['Chittagong', 'Comilla', 'Cox\'s Bazar'],
    'Sylhet': ['Sylhet', 'Moulvibazar', 'Sunamganj'],
    'Rajshahi': ['Rajshahi', 'Bogra', 'Pabna'],
    'Khulna': ['Khulna', 'Jessore', 'Satkhira'],
  };
  List<String> _cities = [];

  final SignupController _signupController = Get.find<SignupController>();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      final bool success = await _signupController.registerUser(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _phoneController.text.trim(),
        _selectedBloodGroup!,
        _selectedDistrict!,
        _selectedCity!,
      );
      if (success) {
        Get.snackbar(
          'Success',
          _signupController.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const SignInPage());
      } else {
        Get.snackbar(
          'Sign Up Failed',
          _signupController.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.red.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextFormField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter your name' : null,
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter your email' : null,
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _phoneController,
                  label: 'Phone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter your phone number' : null,
                ),
                const SizedBox(height: 16),

                // --- BLOOD GROUP DROPDOWN (INLINED) ---
                DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    prefixIcon: const Icon(Icons.bloodtype),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                      .map((label) => DropdownMenuItem<String>(value: label, child: Text(label)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodGroup = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your blood group' : null,
                ),
                const SizedBox(height: 16),

                // --- DISTRICT DROPDOWN (INLINED) ---
                DropdownButtonFormField<String>(
                  value: _selectedDistrict,
                  decoration: InputDecoration(
                    labelText: 'District',
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _locationData.keys
                      .map((label) => DropdownMenuItem<String>(value: label, child: Text(label)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistrict = value;
                      _selectedCity = null;
                      _cities = _locationData[value] ?? [];
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your district' : null,
                ),
                const SizedBox(height: 16),

                // --- CITY DROPDOWN (INLINED) ---
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: InputDecoration(
                    labelText: 'City',
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _cities
                      .map((label) => DropdownMenuItem<String>(value: label, child: Text(label)))
                      .toList(),
                  onChanged: _selectedDistrict == null
                      ? null
                      : (value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        },
                  validator: (value) =>
                      value == null ? 'Please select your city' : null,
                ),
                const SizedBox(height: 24),
                GetBuilder<SignupController>(
                  builder: (controller) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.signupInProgress ? null : _signUp,
                        child: controller.signupInProgress
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Sign Up'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextFormField
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
