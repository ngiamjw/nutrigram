import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/components/setting_class_tile.dart';
import 'package:nutrigram/database/firebase_nutrition.dart';

class ThemeClass {
  void themePicker(BuildContext context, State state) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1C1C1E),
          height: 300,
          child: Column(
            children: [
              // Picker Header with close and confirm buttons
              SettingClassTile(onPressed: () {}, title: 'Gender'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                  },
                  children: const [
                    Center(
                        child: Text(
                      'Light',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text('Dark',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
