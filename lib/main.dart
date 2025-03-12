import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "First App",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Basketball Dashboard",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.cyanAccent
            ], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20), // ✅ Added borderRadius
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            // ✅ Prevent overflow issues
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // ✅ Ensure path is correct in pubspec.yaml
                  height: 120, // Adjusted size
                  width: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                _buildCard(
                    "Basketball is a team sport in which two teams, most commonly of five players each, opposing one another on a rectangular court."),
                const SizedBox(height: 20),
                _buildCard(
                    "A field goal is worth two points unless made from behind the three-point line."),
                const SizedBox(height: 20),
                _buildCard(
                    "The team with the most points at the end of the game wins."),
                const SizedBox(height: 20),
                _buildCard(
                    "The National Basketball Association (NBA) is the most popular"),
                const SizedBox(height: 20),
                _buildCard(
                    "The NBA was founded in New York City on June 6, 1946, as the Basketball Association of America (BAA)."),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                        backgroundColor:
                            Colors.redAccent, // Button background color
                      ),
                      child: const Text("Like"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                        backgroundColor:
                            Colors.green, // Button background color
                      ),
                      child: const Text("Share"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom function to create a card with better design
  Widget _buildCard(String text) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white.withOpacity(0.9), // Light background color
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
