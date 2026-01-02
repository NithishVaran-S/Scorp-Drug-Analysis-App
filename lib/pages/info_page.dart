import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scorp/widgets/app_bar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScorpAppBar(title: "Drug Interaction Info"),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animation
            Center(
                child: Hero(
                  tag: "moreInfoAnim",
                  child: SizedBox(
                    height: 180,
                    child: Lottie.asset("assets/info.json",
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            // Introduction
            _buildInfoCard(
              title: "What Are Drug Interactions?",
              icon: Icons.info,
              content:
                  "Drug interactions occur when two or more medications react with each other, affecting their effectiveness or causing harmful side effects.",
            ),

            // Types of Interactions
            _buildInfoCard(
              title: "Types of Drug Interactions",
              icon: Icons.category,
              content:
                  "🔹 Drug-Drug: Interaction between two medications.\n"
                  "🔹 Drug-Food: Food affects drug effectiveness.\n"
                  "🔹 Drug-Disease: Medication worsens a health condition.",
            ),

            // Severity Levels
            _buildInfoCard(
              title: "Severity Levels",
              icon: Icons.warning,
              content:
                  "🟢 Mild: Minimal effect, usually safe.\n"
                  "🟡 Moderate: Requires monitoring.\n"
                  "🔴 Severe: Can be dangerous, avoid at all costs.",
            ),

            // Safety Tips
            _buildInfoCard(
              title: "Safety Tips",
              icon: Icons.health_and_safety,
              content:
                  "✔️ Always consult a doctor before combining medications.\n"
                  "✔️ Read prescription labels carefully.\n"
                  "✔️ Avoid alcohol or food that interacts with medications.\n"
                  "✔️ Report any side effects to your healthcare provider.",
            ),

            // How to Use the App
            _buildInfoCard(
              title: "How to Use This App",
              icon: Icons.app_shortcut,
              content:
                  "1️⃣ Enter the drug names in the search bar.\n"
                  "2️⃣ View potential interactions and severity levels.\n"
                  "3️⃣ Follow the recommendations for safe usage.\n"
                  "4️⃣ If in doubt, consult a healthcare professional.",
            ),

            // Resources & References
            _buildInfoCard(
              title: "Trusted Resources",
              icon: Icons.link,
              content:
                  "🔗 World Health Organization (WHO)\n"
                  "🔗 Food & Drug Administration (FDA)\n"
                  "🔗 Mayo Clinic Drug Database",
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required String content}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.redAccent, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
