import 'package:flutter/material.dart';

class ApptsScreen extends StatelessWidget {
  const ApptsScreen({super.key});

  // Common colors from the UI
  static const primaryTeal = Color(0xFF40AFC6);
  static const backgroundGray = Color(0xFFF8F4F2);
  static const highlightBlue = Color(0xFFE0F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,
      body: Column(
        children: [
          // Custom Header Section
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 25),
            decoration: const BoxDecoration(color: primaryTeal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Just-In-time",
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Appointments",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _headerIcon(Icons.notifications_none),
                    const SizedBox(width: 10),
                    _headerIcon(Icons.menu),
                  ],
                )
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upcoming Appointments",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    
                    // Appointment List
                    const AppointmentCard(
                      name: "Dr.Wijesekara",
                      type: "Cardiology Checkup",
                      date: "Jan 28, 2026",
                      time: "10:30 AM",
                      status: "Today",
                      isHighlighted: true,
                    ),
                    const AppointmentCard(
                      name: "Dr.Rathnayake",
                      type: "General Consultation",
                      date: "Feb 5, 2026",
                      time: "2:00 PM",
                      status: "Upcoming",
                    ),
                    const AppointmentCard(
                      name: "Dr.Jayaweera",
                      type: "Eye Examination",
                      date: "Feb 12, 2026",
                      time: "11:00 AM",
                      status: "Upcoming",
                    ),

                    const SizedBox(height: 10),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryTeal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Book New Appointment",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryTeal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Queue"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Appts"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Doctor"),
        ],
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String name, type, date, time, status;
  final bool isHighlighted;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.type,
    required this.date,
    required this.time,
    required this.status,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isHighlighted ? ApptsScreen.highlightBlue : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isHighlighted ? ApptsScreen.primaryTeal : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: status == "Today" ? const Color(0xFF1CB5E0) : Colors.grey[600],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          Text(type, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(date, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(width: 20),
              Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(time, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}
