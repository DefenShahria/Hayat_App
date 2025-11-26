import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Dummy data
  final List<Map<String, String>> donationHistory = const [
    {"date": "2025-11-01", "bloodGroup": "B+", "location": "Dhaka", "hospital": "Square Hospital"},
    {"date": "2025-10-01", "bloodGroup": "B+", "location": "Dhaka", "hospital": "United Hospital"},
    {"date": "2025-09-01", "bloodGroup": "B+", "location": "Chittagong", "hospital": "Evercare Hospital"},
    {"date": "2025-08-15", "bloodGroup": "B+", "location": "Sylhet", "hospital": "Dhaka Medical"},
    {"date": "2025-07-10", "bloodGroup": "B+", "location": "Dhaka", "hospital": "Sarwar Hospital"},
    {"date": "2025-06-05", "bloodGroup": "B+", "location": "Khulna", "hospital": "Square Hospital"},
    {"date": "2025-05-20", "bloodGroup": "B+", "location": "Dhaka", "hospital": "United Hospital"},
    {"date": "2025-04-15", "bloodGroup": "B+", "location": "Chittagong", "hospital": "Evercare Hospital"},
    {"date": "2025-03-10", "bloodGroup": "B+", "location": "Sylhet", "hospital": "Dhaka Medical"},
    {"date": "2025-02-05", "bloodGroup": "B+", "location": "Dhaka", "hospital": "Sarwar Hospital"},
    {"date": "2025-01-01", "bloodGroup": "B+", "location": "Khulna", "hospital": "Square Hospital"},
    {"date": "2024-12-15", "bloodGroup": "B+", "location": "Dhaka", "hospital": "United Hospital"},
    {"date": "2024-11-10", "bloodGroup": "B+", "location": "Chittagong", "hospital": "Evercare Hospital"},
    {"date": "2024-10-05", "bloodGroup": "B+", "location": "Sylhet", "hospital": "Dhaka Medical"},
    {"date": "2024-09-01", "bloodGroup": "B+", "location": "Dhaka", "hospital": "Sarwar Hospital"},
    {"date": "2024-08-25", "bloodGroup": "B+", "location": "Khulna", "hospital": "Square Hospital"},
    {"date": "2024-07-20", "bloodGroup": "B+", "location": "Dhaka", "hospital": "United Hospital"},
    {"date": "2024-06-15", "bloodGroup": "B+", "location": "Chittagong", "hospital": "Evercare Hospital"},
    {"date": "2024-05-10", "bloodGroup": "B+", "location": "Sylhet", "hospital": "Dhaka Medical"},
    {"date": "2024-04-05", "bloodGroup": "B+", "location": "Dhaka", "hospital": "Sarwar Hospital"},
  ];


  final List<String> recommendedFoods = const [
    "Spinach & Leafy Greens",
    "Red Meat",
    "Legumes & Beans",
    "Vitamin C rich fruits",
    "Iron-rich cereals"
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate next donation date (3 months from last donation)
    final String nextDonation = donationHistory.isNotEmpty
        ? DateTime.parse(donationHistory.first['date']!)
        .add(const Duration(days: 90))
        .toString()
        .split(' ')[0]
        : "N/A";

    return Scaffold(
      appBar: AppBar(title: const Text('Donation History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- Next Donation ----------------
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.red, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Next Eligible Donation",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 5),
                          Text(nextDonation,
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Donation History ----------------
            const Text("Donation History",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: donationHistory.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = donationHistory[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.bloodtype, color: Colors.red),
                      title: Text("${item['bloodGroup']} donated"),
                      subtitle: Text(
                          "${item['hospital']}, ${item['location']}\nDate: ${item['date']}"),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ---------------- Recommended Foods ----------------
            const Text("Recommended Foods",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
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
            )
          ],
        ),
      ),
    );
  }
}
