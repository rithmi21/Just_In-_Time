import 'package:flutter/material.dart';

class BookAppointmentPage extends StatelessWidget {
  const BookAppointmentPage({super.key});

  // Using the teal color from your Just-In-Time design
  static const primaryTeal = Color(0xFF40AFC6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F2),
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book New Appointment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. Select Doctor
          _buildSectionCard(
            title: "1. Select Doctor",
            child: Column(
              children: [
                _doctorItem("Dr. Wijesekara", "Cardiology"),
                _doctorItem("Dr. Rathnayake", "General Consultation"),
                _doctorItem("Dr. Jayaweera", "Eye Examination"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 2. Select Date & Time
          _buildSectionCard(
            title: "2. Select Date & Time",
            child: Column(
              children: [
                _inputTile(Icons.calendar_today, "Select Date", "2026 / 03 / 20"),
                const SizedBox(height: 12),
                _inputTile(Icons.access_time, "Select Time", "10:30 AM"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 3. Patient Information
          _buildSectionCard(
            title: "3. Patient Information",
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Reason for visit (optional)",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: UnderlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Logic to save booking would go here
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Appointment Booked Successfully!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Confirm Booking",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),

    );
  }

  // --- UI Helpers ---

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _doctorItem(String name, String specialty) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFE0F7FA),
            child: Icon(Icons.person, color: primaryTeal),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(specialty, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.check_circle_outline, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _inputTile(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: primaryTeal, size: 22),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
