import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Bottom_Navigationbar/bottom_navigationBar.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _selectedBloodGroup;
  String? _selectedDistrict;
  String? _selectedCity;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _currentStep = 0;

  late AnimationController _fadeController;

  final Map<String, List<String>> _locationData = {
    'Dhaka': ['Dhaka', 'Gazipur', 'Narayanganj', 'Tangail'],
    'Chittagong': ['Chittagong', 'Comilla', 'Cox\'s Bazar', 'Khagrachari'],
    'Sylhet': ['Sylhet', 'Moulvibazar', 'Sunamganj', 'Habiganj'],
    'Rajshahi': ['Rajshahi', 'Bogra', 'Pabna', 'Naogaon'],
    'Khulna': ['Khulna', 'Jessore', 'Satkhira', 'Bagerhat'],
    'Barishal': ['Barishal', 'Jhalokati', 'Patuakhali', 'Bhola'],
  };

  List<String> _cities = [];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController.forward();

    // Pre-fill name from Google account if available
    final user = FirebaseAuth.instance.currentUser;
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      _nameController.text = user.displayName!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitForm() {
    Get.offAll(BottomNavBar());

    // if (_formKey.currentState!.validate()) {
    //   // Validate password match
    //   if (_passwordController.text != _confirmPasswordController.text) {
    //     Get.snackbar(
    //       'Error',
    //       'Passwords do not match',
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red.shade400,
    //       colorText: Colors.white,
    //     );
    //     return;
    //   }

    //   Get.snackbar(
    //     'Success',
    //     'Profile created successfully!',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.green.shade400,
    //     colorText: Colors.white,
    //   );

    //   // Navigate to home
    //   Get.offAll(() => const BottomNavBar());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Complete Your Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade50, Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeController,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress indicator
                      LinearProgressIndicator(
                        value: (_currentStep + 1) / 3,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.red.shade400,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),

                      const SizedBox(height: 32),

                      // Step titles
                      if (_currentStep == 0) ...[
                        _buildStepHeader(
                          'Step 1 of 3',
                          'Basic Information',
                          'Tell us your name and create a password',
                        ),
                        const SizedBox(height: 32),
                        _buildNameField(),
                        const SizedBox(height: 20),
                        _buildPasswordField(),
                        const SizedBox(height: 20),
                        _buildConfirmPasswordField(),
                      ] else if (_currentStep == 1) ...[
                        _buildStepHeader(
                          'Step 2 of 3',
                          'Blood Information',
                          'Select your blood group for easy identification',
                        ),
                        const SizedBox(height: 32),
                        _buildBloodGroupSelector(),
                      ] else if (_currentStep == 2) ...[
                        _buildStepHeader(
                          'Step 3 of 3',
                          'Location',
                          'Help us find donors near you',
                        ),
                        const SizedBox(height: 32),
                        _buildDistrictSelector(),
                        const SizedBox(height: 20),
                        _buildCitySelector(),
                      ],

                      const SizedBox(height: 48),

                      // Navigation buttons
                      Row(
                        children: [
                          if (_currentStep > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _previousStep,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  'Back',
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          if (_currentStep > 0) const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _nextStep,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                _currentStep == 2 ? 'Complete' : 'Next',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader(String step, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.red.shade400,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _nameController,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'e.g., Ahmed Hassan',
              prefixIcon: const Icon(Icons.person_outline),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              if (value.length < 3) {
                return 'Name must be at least 3 characters';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Minimum 8 characters',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade500,
                ),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Re-enter your password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                child: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey.shade500,
                ),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBloodGroupSelector() {
    final bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Blood Group',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: bloodGroups.length,
          itemBuilder: (context, index) {
            final bloodGroup = bloodGroups[index];
            final isSelected = _selectedBloodGroup == bloodGroup;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedBloodGroup = bloodGroup;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.red.shade400
                      : Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Colors.red.shade400
                        : Colors.grey.shade200,
                    width: isSelected ? 2 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Center(
                  child: Text(
                    bloodGroup,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (_selectedBloodGroup == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Please select a blood group',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red.shade400),
            ),
          ),
      ],
    );
  }

  Widget _buildDistrictSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'District',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedDistrict,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_on_outlined),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
            items: _locationData.keys
                .map(
                  (label) => DropdownMenuItem<String>(
                    value: label,
                    child: Text(label),
                  ),
                )
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
        ),
      ],
    );
  }

  Widget _buildCitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCity,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_city),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
            items: _cities
                .map(
                  (label) => DropdownMenuItem<String>(
                    value: label,
                    child: Text(label),
                  ),
                )
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
        ),
      ],
    );
  }
}
