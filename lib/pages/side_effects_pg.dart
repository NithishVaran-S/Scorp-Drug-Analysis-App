import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scorp/api_service.dart';
import 'package:scorp/widgets/app_bar.dart';

class SideEffectsPage extends StatefulWidget {
  const SideEffectsPage({super.key});

  @override
  State<SideEffectsPage> createState() => _SideEffectsPageState();
}

class _SideEffectsPageState extends State<SideEffectsPage> {
  final TextEditingController _drugController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final ApiService _apiService = ApiService();

  String dosage = "";
  List<String> sideEffects = [];
  String errorMessage = "";
  bool isLoading = false;

  void fetchSideEffects() async {
    FocusScope.of(context).unfocus(); // Hide keyboard

    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    final String drugName = _drugController.text.trim();
    final String ageText = _ageController.text.trim();

    if (drugName.isEmpty || ageText.isEmpty) {
      setState(() {
        errorMessage = "Please enter both drug name and age.";
        isLoading = false;
      });
      return;
    }

    int? age = int.tryParse(ageText);
    if (age == null || age <= 0) {
      setState(() {
        errorMessage = "Please enter a valid age.";
        isLoading = false;
      });
      return;
    }

    final response = await _apiService.getDosageAndSideEffects(drugName, age);

    if (response.containsKey("error")) {
      setState(() {
        errorMessage = response["error"];
        isLoading = false;
      });
    } else {
      setState(() {
        dosage = response["recommended_dosage"];
        sideEffects = List<String>.from(response["side_effects"]);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScorpAppBar(title: "Side Effects"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animation
              Center(
                child: Hero(
                  tag: "sideEffectsAnim",
                  child: SizedBox(
                    height: 180,
                    child: Lottie.asset("assets/side_effects.json",
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Drug Name Input
              TextField(
                controller: _drugController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter Drug Name",
                  labelStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                cursorColor: Colors.redAccent,
              ),
              const SizedBox(height: 12),

              // Age Input
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter Age",
                  labelStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                cursorColor: Colors.redAccent,
              ),
              const SizedBox(height: 16),

              // Fetch Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: fetchSideEffects,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Check Side Effects",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Loading Indicator
              if (isLoading)
                const Center(child: CircularProgressIndicator(color: Colors.redAccent)),

              // Error Message
              if (errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

              // Dosage Information
              if (dosage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  "Recommended Dosage:",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  dosage,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],

              // Side Effects List
              if (sideEffects.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  "Possible Side Effects:",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true, // Fixes overflow issue
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sideEffects.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.warning, color: Colors.redAccent),
                        title: Text(
                          sideEffects[index],
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
