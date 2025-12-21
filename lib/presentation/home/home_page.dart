import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> bloodRequests = [
    {
      "name": "Ali Ahmed",
      "bloodGroup": "B+",
      "location": "Dhaka",
      "hospital": "Square Hospital",
      "phone": "01700000001",
      "gender": "Male",
      "reason": "Surgery",
      "dateTime": "2025-11-28 10:00 AM",
    },
    {
      "name": "Sara Khan",
      "bloodGroup": "A-",
      "location": "Chittagong",
      "hospital": "United Hospital",
      "phone": "01800000002",
      "gender": "Female",
      "reason": "Accident",
      "dateTime": "2025-11-26 02:00 PM",
    },
    {
      "name": "Rashid Hossain",
      "bloodGroup": "O+",
      "location": "Sylhet",
      "hospital": "Evercare Hospital",
      "phone": "01900000003",
      "gender": "Male",
      "reason": "Thalassemia",
      "dateTime": "2025-11-30 09:00 AM",
    },
    {
      "name": "Nadia Begum",
      "bloodGroup": "AB+",
      "location": "Rajshahi",
      "hospital": "Dhaka Medical",
      "phone": "01711111111",
      "gender": "Female",
      "reason": "Anemia",
      "dateTime": "2025-12-01 11:30 AM",
    },
  ];

  final Set<int> expandedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6366F1).withOpacity(0.8),
                      Color(0xFFEC4899).withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blood Requests',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Help save lives today',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final request = bloodRequests[index];
                final isExpanded = expandedIndexes.contains(index);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
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
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
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
                            color: Color(0xFFEC4899).withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFEC4899).withOpacity(0.8),
                                      Color(0xFFF43F5E).withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFEC4899).withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    request['bloodGroup']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      request['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${request['hospital']} • ${request['location']}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Color(0xFFEC4899),
                                size: 28,
                              ),
                            ],
                          ),
                          if (isExpanded) ...[
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.grey.withOpacity(0.2),
                              height: 1,
                            ),
                            const SizedBox(height: 16),
                            _buildDetailRow(
                              Icons.phone_rounded,
                              'Phone',
                              request['phone']!,
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow(
                              Icons.person_rounded,
                              'Gender',
                              request['gender']!,
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow(
                              Icons.medical_information_rounded,
                              'Reason',
                              request['reason']!,
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow(
                              Icons.access_time_rounded,
                              'Date & Time',
                              request['dateTime']!,
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.grey.withOpacity(0.2),
                              height: 1,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        const SnackBar(
                                          content: Text('Request declined'),
                                          duration: Duration(
                                            milliseconds: 1500,
                                          ),
                                        ),
                                      ),
                                  icon: const Icon(Icons.close, size: 18),
                                  label: const Text('Decline'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.grey.shade600,
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        const SnackBar(
                                          content: Text('Request accepted! ✓'),
                                          duration: Duration(
                                            milliseconds: 1500,
                                          ),
                                        ),
                                      ),
                                  icon: const Icon(Icons.check, size: 18),
                                  label: const Text('Accept'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF10B981),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: bloodRequests.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF6366F1), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
