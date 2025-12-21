import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, String>> donationHistory = const [
    {
      "date": "2025-11-01",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "Square Hospital",
    },
    {
      "date": "2025-10-01",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "United Hospital",
    },
    {
      "date": "2025-09-01",
      "bloodGroup": "B+",
      "location": "Chittagong",
      "hospital": "Evercare Hospital",
    },
    {
      "date": "2025-08-15",
      "bloodGroup": "B+",
      "location": "Sylhet",
      "hospital": "Dhaka Medical",
    },
    {
      "date": "2025-07-10",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "Sarwar Hospital",
    },
    {
      "date": "2025-06-05",
      "bloodGroup": "B+",
      "location": "Khulna",
      "hospital": "Square Hospital",
    },
    {
      "date": "2025-05-20",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "United Hospital",
    },
    {
      "date": "2025-04-15",
      "bloodGroup": "B+",
      "location": "Chittagong",
      "hospital": "Evercare Hospital",
    },
    {
      "date": "2025-03-10",
      "bloodGroup": "B+",
      "location": "Sylhet",
      "hospital": "Dhaka Medical",
    },
    {
      "date": "2025-02-05",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "Sarwar Hospital",
    },
    {
      "date": "2025-01-01",
      "bloodGroup": "B+",
      "location": "Khulna",
      "hospital": "Square Hospital",
    },
    {
      "date": "2024-12-15",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "United Hospital",
    },
    {
      "date": "2024-11-10",
      "bloodGroup": "B+",
      "location": "Chittagong",
      "hospital": "Evercare Hospital",
    },
    {
      "date": "2024-10-05",
      "bloodGroup": "B+",
      "location": "Sylhet",
      "hospital": "Dhaka Medical",
    },
    {
      "date": "2024-09-01",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "Sarwar Hospital",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nextDonation = donationHistory.isNotEmpty
        ? DateTime.parse(
            donationHistory.first['date']!,
          ).add(const Duration(days: 90)).toString().split(' ')[0]
        : "N/A";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF06B6D4).withOpacity(0.8),
                      Color(0xFF0891B2).withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Donation History',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your generosity saves lives',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Color(0xFF1A1A2E).withOpacity(0.7)
                        : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF06B6D4).withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Donation Available',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF06B6D4).withOpacity(0.8),
                                  Color(0xFF0891B2).withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF06B6D4).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nextDonation,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'You\'ve donated ${donationHistory.length} times',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Donation Timeline',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 12),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = donationHistory[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Color(0xFF1A1A2E).withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF06B6D4).withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Color(0xFF06B6D4).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.bloodtype_rounded,
                            color: Color(0xFF06B6D4),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item['bloodGroup']} at ${item['hospital']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${item['location']} • ${item['date']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF10B981),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: donationHistory.length),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }
}
