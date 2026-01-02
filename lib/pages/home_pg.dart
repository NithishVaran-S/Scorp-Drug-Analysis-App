import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scorp/pages/info_page.dart';
import 'package:scorp/pages/interaction_pg.dart';
import 'package:scorp/pages/side_effects_pg.dart';
import 'package:scorp/pages/chatbot_page.dart'; 
import 'package:scorp/widgets/app_bar.dart';
import 'package:scorp/widgets/bottom_navigationbar.dart';

class ScorpHomePage extends StatefulWidget {
  ScorpHomePage({super.key});

  @override
  State<ScorpHomePage> createState() => _ScorpHomePageState();
}

class _ScorpHomePageState extends State<ScorpHomePage> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const ScorpAppBar(title: "Scorp"),
      bottomNavigationBar: ScorpBottomNavBar(currentIndex: _selectedIndex, onTap: _onNavItemTapped),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: _buildCard(
                          context,
                          "Drug Interactions",
                          "assets/interaction.json",
                          const InteractionPage(),
                          "interactionAnim")),
                  const SizedBox(height: 16, width: 16),
                  Flexible(
                      child: _buildCard(
                          context,
                          "Side Effects",
                          "assets/side_effects.json",
                          const SideEffectsPage(),
                          "sideEffectsAnim")),
                  const SizedBox(height: 16, width: 16),
                  Flexible(
                      child: _buildCard(
                          context,
                          "More Info",
                          "assets/info.json",
                          const InfoPage(),
                          "moreInfoAnim")),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatBotPage()),
            );
          },
          backgroundColor: Colors.redAccent,
          shape: const CircleBorder(),
          child: const Icon(Icons.chat,
              color: Colors.white, size: 36), // Bigger Icon
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String animationPath,
      Widget nextPage, String heroTag) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => nextPage,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: SizedBox(
        width: 300,
        height: 250,
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: heroTag, // Unique tag for animation transition
                  child: SizedBox(
                    height: 120,
                    child: Lottie.asset(animationPath, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
