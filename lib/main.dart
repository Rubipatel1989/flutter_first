import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Basketball Dashboard",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Arial',
      ),
      home: const BasketballDashboard(),
    );
  }
}

class BasketballDashboard extends StatelessWidget {
  const BasketballDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "🏀 Basketball Dashboard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent,
              Colors.deepOrange,
              Colors.orange
            ], // Warm colors matching basketball theme
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo with circular border
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.png', // ✅ Make sure image exists
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Basketball Info Cards
                _buildCard("Basketball is a team sport in which two teams, most commonly of five players each, compete."),
                _buildCard("A field goal is worth two points unless made from behind the three-point line."),
                _buildCard("The team with the most points at the end of the game wins."),
                _buildCard("The NBA was founded in New York City on June 6, 1946."),
                _buildCard("LeBron James and Michael Jordan"),
                _buildCard("The Golden State Warriors are the current NBA champions."),
                _buildCard("The Los Angeles Lakers are the current NBA."),

                const SizedBox(height: 20),

                // Like and Share Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(Icons.thumb_up, "Like", Colors.redAccent),
                    _buildButton(Icons.share, "Share", Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🏀 Custom function to create a stylish card with shadow
  Widget _buildCard(String text) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.95),
      shadowColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  // 🏀 Function to create interactive buttons
  Widget _buildButton(IconData icon, String label, Color color) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Text color
        backgroundColor: color, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 6,
      ),
    );
  }
}
