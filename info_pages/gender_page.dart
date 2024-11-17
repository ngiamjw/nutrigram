import 'package:flutter/material.dart';
import 'package:nutrigram/classes/user_data.dart';
import 'package:nutrigram/components/my_info_box.dart';
import 'package:nutrigram/theme/app_color.dart';

class GenderPage extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;

  GenderPage(
      {super.key, required this.user_data, required this.onValidationChanged});

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGray,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Gender",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 150,
          ),
          MyBox(
            title: 'Male',
            isSelected: widget.user_data.gender == 'Male',
            onTap: () {
              setState(() {
                widget.user_data.gender = 'Male';
                widget.onValidationChanged(true);
              });
            },
          ),
          MyBox(
            title: 'Female',
            isSelected: widget.user_data.gender == 'Female',
            onTap: () {
              setState(() {
                widget.user_data.gender = 'Female';
                widget.onValidationChanged(true);
              });
            },
          ),
        ],
      ),
    );
  }
}
