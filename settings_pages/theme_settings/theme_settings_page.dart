import 'package:flutter/material.dart';
import 'package:nutrigram/components/setting_tile.dart';
import 'package:nutrigram/settings_pages/theme_settings/theme_class.dart';
import 'package:nutrigram/settings_pages/unit_settings/unit_class.dart';

class ThemeSettingsPage extends StatefulWidget {
  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeClass themeClass = ThemeClass();
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Theme',
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
            // Theme Option Tile
            SettingsTile(
              title: "Theme",
              value: "Dark",
              onTap: () {
                // Handle navigation for theme settings
                themeClass.themePicker(context, this);
              },
            ),
          ],
        ),
      ),
    );
  }
}
