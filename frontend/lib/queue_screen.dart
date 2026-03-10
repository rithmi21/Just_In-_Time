import 'package:flutter/material.dart';

class QueueScreen extends StatelessWidget {
  // LOGIC: Set this to < 5 to see the Red Alert, or >= 5 for Green
  final int estimatedWait = 4; 

  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine card colors based on wait time
    bool isUrgent = estimatedWait < 5;
    Color alertColor = isUrgent ? const Color(0xFFEF4444) : const Color(0xFF22C55E);
    Color alertBg = isUrgent ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. UPDATED HEADER
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Column(
                children: [
                  // 2. QUEUE PROGRESS CARD
                  _buildProgressCard(),
                  const SizedBox(height: 24),

                  // 3. DOCTOR'S PACE CARD
                  _buildPaceCard(),
                  const SizedBox(height: 24),

                  // 4. DYNAMIC URGENCY CARD
                  _buildUrgencyCard(isUrgent, alertColor, alertBg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF06B6D4), // Cyan Brand Color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Just-In-time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Live Queue", // Updated Subtitle
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildHeaderCircleButton(Icons.notifications_none),
              const SizedBox(width: 12),
              _buildHeaderCircleButton(Icons.menu),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCircleButton(IconData icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Translucent effect
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Queue Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("75%", style: TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.75,
              minHeight: 12,
              backgroundColor: Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tokenLabel("Token #15", const Color(0xFF06B6D4)),
              _tokenLabel("Your Token #25", const Color(0xFF22C55E)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPaceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA), // Light blue background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFB2EBF2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF00ACC1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.access_time, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Doctor's Pace", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Average Time per Patient", style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: const [
                Text("8", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
                Text("minutes per patient", style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _paceStat("Patients seen", "15"),
              const SizedBox(width: 12),
              _paceStat("Remaining", "10"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUrgencyCard(bool isUrgent, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, child: const Icon(Icons.near_me, color: Colors.white, size: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Should I leave Now?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      isUrgent ? "You may miss your turn! Leave Immediately" : "You have plenty of time.",
                      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          _infoRow(Icons.location_on_outlined, "Your Travel time", "22 mins"),
          _infoRow(Icons.access_time, "Estimated wait", "$estimatedWait mins"),
          _infoRow(Icons.send_outlined, "Suggested departure", isUrgent ? "Now" : "In 15 mins"),
        ],
      ),
    );
  }

  Widget _tokenLabel(String text, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _paceStat(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black45),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.black87)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}