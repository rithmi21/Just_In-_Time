import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    int waitTime = 4; 
    bool isLate = waitTime <= 5;

    return Scaffold(
      key: _scaffoldKey, 
      backgroundColor: Colors.white,
      endDrawer: _buildDrawer(context),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Important for emulator drag
        child: Column(
          children: [
            _buildInteractiveHeader(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildDoctorCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildETASection(isLate, waitTime),
            ),
            const SizedBox(height: 20),
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
            _buildNavigationGrid(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- FIXED DRAWER LOGIC ---
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF06B6D4)),
            child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline), 
            title: const Text("Profile"), 
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/profile'); // Navigates correctly
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined), 
            title: const Text("Settings"), 
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/settings'); // Navigates correctly
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---
  Widget _buildInteractiveHeader(BuildContext context) {
    return Container(
      height: 168,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
      decoration: const BoxDecoration(color: Color(0xFF06B6D4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Just-In-time", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              Text("Good Morning", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          Row(
            children: [
              _glassIcon(Icons.notifications_none, () => Navigator.pushNamed(context, '/notifications')),
              const SizedBox(width: 15),
              _glassIcon(Icons.menu, () => _scaffoldKey.currentState?.openEndDrawer()),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNavigationGrid() {
    return Padding(
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
    );
  }

  // (Include all your existing _glassIcon, _statCard, _gridButton, etc. helpers below)
  Widget _glassIcon(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
      child: Icon(icon, color: Colors.white, size: 28),
    ),
  );

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13B9CE), 
        borderRadius: BorderRadius.circular(25), 
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _badge("My Next Appointment"),
          _activeBadge(),
        ]),
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

  Widget _badge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11)),
  );

  Widget _activeBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
    child: const Text("~ Active", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
  );

  Widget _buildETASection(bool isLate, int waitTime) {
    Color statusColor = isLate ? const Color(0xFFEF4444) : const Color(0xFF22C55E);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: statusColor.withOpacity(0.3)),
        color: statusColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Row(children: [
          CircleAvatar(backgroundColor: statusColor, radius: 15, child: const Icon(Icons.near_me, color: Colors.white, size: 15)),
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
                Text("You may miss your turn!", style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
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
      Icon(icon, color: const Color(0xFF06B6D4)), 
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
          Icon(icon, color: const Color(0xFF06B6D4)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ]),
      ),
    ),
  );
}