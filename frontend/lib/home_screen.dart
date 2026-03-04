import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // --- DESIGN LOGIC ---
    int waitTime = 0; // Set to 0 for Red alert
    bool isLate = waitTime <= 0;

    return SingleChildScrollView(
      child: Column(
        children: [
          // --- 1. HEADER (Fixed Height 168, No overlap) ---
          Container(
            height: 168,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
            decoration: BoxDecoration(
              color: const Color(0xFF06B6D4), //
              border: Border.all(color: Colors.white, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Just-In-time", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                    Text("Good Morning", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    _glassIcon(Icons.notifications_none),
                    const SizedBox(width: 15),
                    _glassIcon(Icons.menu),
                  ],
                )
              ],
            ),
          ),

          // --- 2. DOCTOR CARD (Now placed naturally BELOW the header) ---
          Padding(
            padding: const EdgeInsets.all(20.0), // Adds space around the card
            child: _buildDoctorCard(),
          ),

          // --- 3. ETA SECTION ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildETASection(isLate, waitTime),
          ),

          const SizedBox(height: 20),

          // --- 4. STATS ROW (The 3 Cards) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard(Icons.people_outline, isLate ? "0" : "2", "ahead"),
                _statCard(Icons.access_time, "8", "min/patient"),
                _statCard(Icons.timeline, "100%", "Progress"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- 5. NAVIGATION GRID ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    _gridButton(Icons.list_alt, "Live Queue", () => onNavigate(1)),
                    const SizedBox(width: 15),
                    _gridButton(Icons.map_outlined, "Navigation", () => onNavigate(4)),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _gridButton(Icons.calendar_month, "Appointments", () => onNavigate(2)),
                    const SizedBox(width: 15),
                    _gridButton(Icons.domain, "Clinic Info", () => onNavigate(5)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13B9CE), 
        borderRadius: BorderRadius.circular(25), 
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // --- BADGES: My Next Appointment & Active ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
              child: const Text("My Next Appointment", style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: const Text("~ Active", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text("Dr. Wijesekara", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const Text("Cardiologist", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: _tokenSubBox("Now Treating", "#25")),
          const SizedBox(width: 10),
          Expanded(child: _tokenSubBox("Your Token", "#25")),
        ]),
      ]),
    );
  }

  Widget _buildETASection(bool isLate, int waitTime) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: isLate ? Colors.red.shade400 : Colors.green.shade200),
        color: isLate ? Colors.red.withOpacity(0.05) : Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Row(children: [
          CircleAvatar(backgroundColor: isLate ? Colors.red : Colors.green, radius: 15),
          const SizedBox(width: 10),
          const Text("Estimated Time of Arrival", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ]),
        if (isLate) 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 16),
                const SizedBox(width: 5),
                Text("You may miss your turn! Leave Immediately", 
                  style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _timeBox("Wait Time", waitTime.toString()),
          _timeBox("Travel Time", "10"),
        ]),
      ]),
    );
  }

  Widget _glassIcon(IconData icon) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
    child: Icon(icon, color: Colors.white, size: 28),
  );

  Widget _tokenSubBox(String t, String v) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(10)),
    child: Column(children: [
      Text(t, style: const TextStyle(color: Colors.white70, fontSize: 10)), 
      Text(v, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
    ]),
  );

  Widget _timeBox(String label, String val) => Column(children: [
    Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    const Text("mins", style: TextStyle(fontSize: 10, color: Colors.grey)),
  ]);

  Widget _statCard(IconData icon, String val, String sub) => Container(
    width: 100, padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
    child: Column(children: [
      Icon(icon, color: Colors.blue), 
      const SizedBox(height: 5),
      Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
      Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    ]),
  );

  Widget _gridButton(IconData icon, String label, VoidCallback onTap) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.cyan),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ]),
      ),
    ),
  );
}