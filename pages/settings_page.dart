import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/database/firebase_nutrition.dart';
import 'package:nutrigram/info_pages/goals_page.dart';
import 'package:nutrigram/pages/home_page.dart';
import 'package:nutrigram/settings_pages/account_page.dart';
import 'package:nutrigram/settings_pages/goal_setting/goal_setting_page.dart';
import 'package:nutrigram/settings_pages/nutrition_settings_page.dart';
import 'package:nutrigram/settings_pages/profile_page/profile_page.dart';
import 'package:nutrigram/settings_pages/theme_settings/theme_settings_page.dart';
import 'package:nutrigram/settings_pages/unit_settings/unit_settings_page.dart';
import 'package:nutrigram/theme/app_color.dart';

class SettingsPage extends StatelessWidget {
  FirestoreServiceNutrition firestoreservice = FirestoreServiceNutrition();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF1C1C1E),
      ),
      backgroundColor: Color(0xFF1C1C1E), // Dark background
      body: StreamBuilder<DocumentSnapshot>(
          stream: firestoreservice.getUserStream('ngiamjw@gmail.com'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            Map<String, dynamic> recommendedNutrition =
                userData['recommendedNutrition'];

            Map<String, dynamic> user_info = userData['user_info'];

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: ListView(
                children: [
                  // Account Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Account",
                      style: TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Profile
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  user_info: user_info,
                                )),
                      );
                    },
                    child: _buildListTile(
                      icon: Icons.person_outline,
                      title: "Profile",
                    ),
                  ),
                  // Account
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountSettingsPage(
                                  user_info: user_info,
                                )),
                      );
                    },
                    child: _buildListTile(
                      icon: Icons.lock_outline,
                      title: "Account",
                    ),
                  ),
                  // Notifications
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                    },
                    child: _buildListTile(
                      icon: Icons.notifications_outlined,
                      title: "Notifications",
                    ),
                  ),

                  SizedBox(height: 20), // Space between sections

                  // Preferences Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Preferences",
                      style: TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Workouts
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoalSettingPage(
                                  user_info: user_info,
                                )),
                      );
                    },
                    child: _buildListTile(
                      icon: Icons.fitness_center_outlined,
                      title: "Goals",
                    ),
                  ),
                  // Units
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UnitSettingsPage(
                                  user_info: user_info,
                                )),
                      );
                    },
                    child: _buildListTile(
                      icon: Icons.straighten_outlined,
                      title: "Units",
                    ),
                  ),
                  // Language
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NutritionSettingsPage(
                                  recommendedNutrition: recommendedNutrition,
                                )),
                      );
                    },
                    child: _buildListTile(
                      icon: Icons.local_pizza,
                      title: "Nutrition",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThemeSettingsPage()),
                      );
                    },
                    child: _buildListTile(
                      icon: Icons.straighten_outlined,
                      title: "Theme",
                    ),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        backgroundColor: AppColors.charcoalGray,
        color: Color(0xFF2C2C2E),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.bar_chart, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          // Handle navigation bar taps if needed
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

  // Helper function to build a list tile
  Widget _buildListTile({
    required IconData icon,
    required String title,
    bool proLabel = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (proLabel)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "PRO",
                style: TextStyle(
                  color: Color(0xFFF7C948),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Icon(Icons.chevron_right, color: Colors.grey, size: 24),
        ],
      ),
    );
  }
}
