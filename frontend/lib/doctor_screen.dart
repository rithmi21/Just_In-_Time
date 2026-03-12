import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      // Bottom Navigation matches the screenshot's footer
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 3, 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Queue'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Appts'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Doctor'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _profileCard(),
                  const SizedBox(height: 16),
                  _availabilityCard(),
                  const SizedBox(height: 16),
                  _queueHistoryCard(),
                  const SizedBox(height: 16),
                  _performanceCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _header() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
      color: const Color(0xFF53C8D8),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Just-In-time', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              Text('Doctor Status', style: TextStyle(color: Colors.white70)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 15),
              Icon(Icons.menu, color: Colors.white),
            ],
          )
        ],
      ),
    );
  }

  Widget _profileCard() {
    return _cardWrapper(
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF00BCD4),
                child: Text('W', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dr.Wijesekara', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text('Cardiologist', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(6)),
                    child: const Text('Active', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _statBox('Experience', '12 Years'),
              const SizedBox(width: 10),
              _statBox('Rating', '4.8'),
            ],
          )
        ],
      ),
    );
  }

  Widget _availabilityCard() {
    return _cardWrapper(
      title: 'Current Availability',
      child: Column(
        children: [
          _statusTile('Active', Colors.green, true),
          _statusTile('On Break', Colors.orange, false),
          _statusTile('Emergency/Away', Colors.amber, false),
        ],
      ),
    );
  }

  Widget _queueHistoryCard() {
    return _cardWrapper(
      title: 'Session Queue History',
      icon: Icons.history,
      child: Column(
        children: [
          _dataRow('Total Tokens Today', '25', const Color(0xFFE1F5FE), Colors.black),
          _dataRow('Completed', '15', const Color(0xFFE8F5E9), Colors.green),
          _dataRow('Remaining', '10', const Color(0xFFFFF8E1), Colors.orange),
        ],
      ),
    );
  }

  Widget _performanceCard() {
    return _cardWrapper(
      title: "Today's Performance",
      child: Column(
        children: [
          _progressRow('Avg. Time per Patient', '9 min', 0.6),
          _progressRow('Queue Efficiency', '90%', 0.9),
          _progressRow('On-Time Rate', '85%', 0.85),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _cardWrapper({String? title, IconData? icon, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(children: [
              if (icon != null) Icon(icon, size: 16, color: Colors.cyan),
              if (icon != null) const SizedBox(width: 5),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ]),
            const SizedBox(height: 15),
          ],
          child,
        ],
      ),
    );
  }

  Widget _statBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFFE1F5FE), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _statusTile(String label, Color color, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Colors.green.withOpacity(0.05) : Colors.transparent,
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          const Spacer(),
          if (isSelected) const Icon(Icons.check_circle, color: Colors.green, size: 18),
        ],
      ),
    );
  }

  Widget _dataRow(String label, String value, Color bg, Color textCol) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: textCol)),
        ],
      ),
    );
  }

  Widget _progressRow(String label, String value, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            minHeight: 5,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}
