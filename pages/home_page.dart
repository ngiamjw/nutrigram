import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/pages/nutrition_page.dart';
import 'package:nutrigram/pages/settings_page.dart';
import 'package:nutrigram/pages/workout_page.dart';
import 'package:nutrigram/theme/app_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGray,
      body: Column(
        children: [
          // Top Bar
          Padding(
            padding: const EdgeInsets.only(top: 55, left: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 40,
                      color: Colors.blue.shade500,
                    ), // Food logo
                    SizedBox(width: 8),
                    Text("GYM FREAK",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade100)),
                  ],
                ),
              ],
            ),
          ),
          // Page Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _pageController.jumpToPage(0),
                child: Column(
                  children: [
                    Text("Nutrition",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _currentPage == 0 ? Colors.blue : Colors.grey,
                        )),
                    if (_currentPage == 0)
                      Container(
                        height: 2,
                        width: 60,
                        color: Colors.blue,
                        margin: EdgeInsets.only(top: 4),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _pageController.jumpToPage(1),
                child: Column(
                  children: [
                    Text("Workout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _currentPage == 1 ? Colors.blue : Colors.grey,
                        )),
                    if (_currentPage == 1)
                      Container(
                        height: 2,
                        width: 60,
                        color: Colors.blue,
                        margin: EdgeInsets.only(top: 4),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                NutritionPage(),
                WorkoutPage(),
              ],
            ),
          ),
        ],
      ),

      // Curved Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        backgroundColor: AppColors.charcoalGray,
        color: Color(0xFF2C2C2E),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.bar_chart, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          // Handle navigation bar taps if needed
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),
    );
  }
}
