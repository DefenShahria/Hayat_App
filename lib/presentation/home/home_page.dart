import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy blood requests data
  final List<Map<String, String>> bloodRequests = [
    {
      "name": "Ali Ahmed",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "Square Hospital",
      "phone": "01700000001",
      "gender": "Male",
      "reason": "Surgery",
      "dateTime": "2025-11-28 10:00 AM"
    },
    {
      "name": "Sara Khan",
      "bloodGroup": "A-",
      "location": "Chittagong",
      "hospital": "United Hospital",
      "phone": "01800000002",
      "gender": "Female",
      "reason": "Accident",
      "dateTime": "2025-11-26 02:00 PM"
    },
    {
      "name": "Rashid Hossain",
      "bloodGroup": "O+",
      "location": "Sylhet",
      "hospital": "Evercare Hospital",
      "phone": "01900000003",
      "gender": "Male",
      "reason": "Thalassemia",
      "dateTime": "2025-11-30 09:00 AM"
    },
    {
      "name": "Nadia Begum",
      "bloodGroup": "AB+",
      "location": "Rajshahi",
      "hospital": "Dhaka Medical",
      "phone": "01711111111",
      "gender": "Female",
      "reason": "Anemia",
      "dateTime": "2025-12-01 11:30 AM"
    },
  ];

  // Track which card is expanded
  final Set<int> expandedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Requests')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: bloodRequests.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final request = bloodRequests[index];
            final isExpanded = expandedIndexes.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isExpanded) {
                    expandedIndexes.remove(index);
                  } else {
                    expandedIndexes.add(index);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: Name & Blood Group
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              request['bloodGroup']!,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            request['name']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Text(
                      "${request['hospital']}, ${request['location']}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500),
                    ),

                    // Expanded content
                    if (isExpanded) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.phone, "Phone", request['phone']!),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.person, "Gender", request['gender']!),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.info, "Reason", request['reason']!),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                          Icons.calendar_today, "Need Date & Time", request['dateTime']!),
                    ],

                    const SizedBox(height: 12),
                    // Accept & Decline buttons always visible
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            // Accept logic
                          },
                          child: const Text("Accept", style: TextStyle(fontSize: 16)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            // Decline logic
                          },
                          child: const Text("Decline", style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
