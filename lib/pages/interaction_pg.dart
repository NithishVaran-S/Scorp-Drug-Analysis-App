import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scorp/api_service.dart';
import 'package:scorp/widgets/app_bar.dart';

class InteractionPage extends StatefulWidget {
  const InteractionPage({super.key});

  @override
  State<InteractionPage> createState() => _InteractionPageState();
}

class _InteractionPageState extends State<InteractionPage> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> interactions = [];
  String errorMessage = "";
  bool isLoading = false; // Loading state

  void fetchInteractions() async {
    FocusScope.of(context).unfocus(); // Hide keyboard
    setState(() {
      errorMessage = "";
      isLoading = true; // Start loading
      interactions = [];
    });

    List<String> drugs =
        _controller.text.split(',').map((e) => e.trim()).toList();
    final response = await _apiService.getDrugInteractions(drugs);

    if (response.containsKey("error")) {
      setState(() {
        errorMessage = response["error"];
        interactions = [];
        isLoading = false; // Stop loading
      });
    } else {
      setState(() {
        interactions =
            List<Map<String, dynamic>>.from(response["interactions"]);
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard when tapping outside
      child: Scaffold(
        appBar: const ScorpAppBar(title: "Drug Interactions"),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animation
              Center(
                child: Hero(
                  tag: "interactionAnim",
                  child: SizedBox(
                    height: 180,
                    child: Lottie.asset("assets/interaction.json",
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Text Field
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter Drugs (comma separated)",
                  labelStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Colors.redAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                cursorColor: Colors.redAccent,
              ),

              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: fetchInteractions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Check Interactions",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Loading Indicator
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(color: Colors.redAccent),
                ),

              // Error Message
              if (errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),

              // List of Interactions
              Expanded(
                child: interactions.isNotEmpty
                    ? ListView.builder(
                        itemCount: interactions.length,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          final interaction = interactions[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 6,
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "💊 ${interaction['drug_pair'][0]} & ${interaction['drug_pair'][1]}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "🛑 Severity: ${interaction['severity']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.redAccent),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "📖 Description: ${interaction['description']}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white70),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "💡 Recommendation: ${interaction['recommendation']}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : !isLoading // Show default message if not loading
                        ? const Center(
                            child: Text(
                              "Enter drugs and check for interactions.",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70),
                            ),
                          )
                        : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
