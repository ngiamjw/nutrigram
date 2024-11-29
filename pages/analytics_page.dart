import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/pages/analytics_nutrition.dart';
import 'package:nutrigram/pages/analytics_workout.dart';
import 'package:nutrigram/pages/home_page.dart';
import 'package:nutrigram/pages/nutrition_page.dart';
import 'package:nutrigram/pages/settings_page.dart';
import 'package:nutrigram/theme/app_color.dart';

class AnalyticsPage extends StatefulWidget {
  int currentpage;
  AnalyticsPage({super.key, required this.currentpage});
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
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
                          color: widget.currentpage == 0
                              ? Colors.blue
                              : Colors.grey,
                        )),
                    if (widget.currentpage == 0)
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
                          color: widget.currentpage == 1
                              ? Colors.blue
                              : Colors.grey,
                        )),
                    if (widget.currentpage == 1)
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
                  widget.currentpage = index;
                });
              },
              children: [
                AnalyticsNutrition(),
                AnalyticsWorkout(),
              ],
            ),
          ),
        ],
      ),

      // Curved Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        currentpage: 0,
                      )),
            );
          }
        },
      ),
    );
  }
}
