import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/components/setting_tile.dart';
import 'package:nutrigram/settings_pages/account_page.dart';
import 'package:nutrigram/settings_pages/profile_page/profile_class.dart';

class ProfilePage extends StatefulWidget {
  Map<String, dynamic> user_info;
  ProfilePage({super.key, required this.user_info});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  profileClass profileclass = profileClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: [
            // Profile Section
            SettingsTile(
              title: "User Name",
              value: "JWNgiam",
              onTap: () {
                // Handle navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettingsPage(
                            user_info: widget.user_info,
                          )),
                );
              },
            ),
            SettingsTile(
              title: "Height",
              value:
                  "${widget.user_info['height']} ${widget.user_info['length_unit']}",
              onTap: () {
                // Handle navigation
                profileclass.showHeightPicker(context, widget.user_info, this);
              },
            ),
            SettingsTile(
              title: "Weight",
              value:
                  "${widget.user_info['weight']}${widget.user_info['weight_unit']}",
              onTap: () {
                // Handle navigation
                profileclass.showWeightPicker(context, widget.user_info, this);
              },
            ),
            SettingsTile(
                title: "Sex",
                value: "${widget.user_info['gender']}",
                onTap: () => profileclass.showSexPicker(
                    context, widget.user_info, this)),
            SettingsTile(
                title: "Date of Birth",
                value: "14 Nov 2004",
                onTap: () => profileclass.showDatePicker(
                    context, widget.user_info, this)),
            SettingsTile(
              title: "Email Address",
              value: "ngiamjw@gmail.com",
              onTap: () {
                // Handle navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettingsPage(
                            user_info: widget.user_info,
                          )),
                );
              },
            ),
            SettingsTile(
              title: "Workouts per week",
              value: "${widget.user_info['workoutsPerWeek']}",
              onTap: () {
                // Handle navigation
                profileclass.WorkoutPicker(context, widget.user_info, this);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get month name
}
