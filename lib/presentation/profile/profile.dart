import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> recommendedFoods = const [
    "Spinach & Leafy Greens",
    "Red Meat",
    "Legumes & Beans",
    "Vitamin C rich fruits",
    "Iron-rich cereals"
  ];

  int daysLeft = 85; // Your dynamic value here
  int maxDays = 90;

  @override
  Widget build(BuildContext context) {
    double progress = (maxDays - daysLeft) / maxDays;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Info',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ListTile(leading: Icon(Icons.person), title: Text('Ali')),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Ali@example.com'),
            ),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Change Theme'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                      );
                      setState(() {});
                    },
                    icon: Icon(
                      Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ---------------- NEXT DONATION CARD WITH SHADE ----------------
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.red, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Next Eligible Donation",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 5),
                              Text("$daysLeft days left",
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ----------- PROGRESS / SHADE BAR -----------
                    Stack(
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: progress, // 0 -> 1
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Recommended Foods ----------------
            const Text("Recommended Foods",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedFoods.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        recommendedFoods[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
