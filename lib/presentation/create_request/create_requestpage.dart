import 'package:flutter/material.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  String? selectedBloodGroup;
  String? selectedHospital;
  String? selectedLocation;
  String? selectedPhone;

  List<String> phoneNumbers = ["01700000000", "01800000000"];
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Request"),
        centerTitle: true,
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
        child: Column(
          children: [
            /// --------------------- CREATE REQUEST BUTTON ---------------------
            GestureDetector(
              onTap: () => _showCreateRequestPopup(),
              child: Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.red, width: 2),
                  color: Colors.red.withOpacity(0.08),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 35),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        "Create Blood Request",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 22),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// --------------------- BANNERS SECTION ---------------------
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage("assets/banner.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // -------------------------- POPUP FUNCTION --------------------------
  void _showCreateRequestPopup() {
    // Pre-fill phoneController if a number is already selected
    if (selectedPhone != null) phoneController.text = selectedPhone!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                "Create Blood Request",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              _buildDropdown(
                label: "Select Blood Group",
                value: selectedBloodGroup,
                items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
                onChanged: (v) => setState(() => selectedBloodGroup = v),
              ),

              const SizedBox(height: 15),

              _buildDropdown(
                label: "Select Location",
                value: selectedLocation,
                items: ["Dhaka", "Chittagong", "Sylhet", "Rajshahi", "Khulna"],
                onChanged: (v) => setState(() => selectedLocation = v),
              ),

              const SizedBox(height: 15),

              _buildDropdown(
                label: "Select Hospital",
                value: selectedHospital,
                items: [
                  "Square Hospital",
                  "United Hospital",
                  "Dhaka Medical",
                  "Evercare Hospital",
                  "Sarwar Hospital"
                ],
                onChanged: (v) => setState(() => selectedHospital = v),
              ),

              const SizedBox(height: 15),

              // ------------------ Phone Section ------------------
              const Text("Phone Number"),
              const SizedBox(height: 5),

              DropdownButtonFormField<String>(
                value: selectedPhone,
                items: phoneNumbers
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    selectedPhone = v;
                    phoneController.text = v ?? "";
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Edit Phone Number",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Use phoneController.text for the final phone number
                    String finalPhone = phoneController.text;
                    // Perform submit logic here
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Submit Request",
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------- REUSABLE DROPDOWN WIDGET ---------------------
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
