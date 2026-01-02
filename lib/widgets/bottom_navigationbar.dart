import 'package:flutter/material.dart';

class ScorpBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ScorpBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<ScorpBottomNavBar> createState() => _ScorpBottomNavBarState();
}

class _ScorpBottomNavBarState extends State<ScorpBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.white60,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
