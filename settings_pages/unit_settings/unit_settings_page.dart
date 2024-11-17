import 'package:flutter/material.dart';
import 'package:nutrigram/components/setting_tile.dart';
import 'package:nutrigram/settings_pages/unit_settings/unit_class.dart';

class UnitSettingsPage extends StatefulWidget {
  Map<String, dynamic> user_info;
  UnitSettingsPage({super.key, required this.user_info});

  @override
  State<UnitSettingsPage> createState() => _UnitSettingsPageState();
}

class _UnitSettingsPageState extends State<UnitSettingsPage> {
  @override
  Widget build(BuildContext context) {
    UnitClass unitclass = UnitClass();
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Units',
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
            // Length Units Tile
            SettingsTile(
              title: "Length",
              value: widget.user_info['length_unit'],
              onTap: () {
                // Handle navigation for Length units settings
                unitclass.showLengthPicker(context, widget.user_info, this);
              },
            ),
            // Weight Units Tile
            SettingsTile(
              title: "Weight",
              value: widget.user_info['weight_unit'],
              onTap: () {
                // Handle navigation for Weight units settings
                unitclass.showWeightPicker(context, widget.user_info, this);
              },
            ),
          ],
        ),
      ),
    );
  }
}
