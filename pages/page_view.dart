import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram/classes/user_data.dart';
import 'package:nutrigram/database/firebase_nutrition.dart';
import 'package:nutrigram/info_pages/calendar.dart';
import 'package:nutrigram/info_pages/gender_page.dart';
import 'package:nutrigram/info_pages/goals_page.dart';
import 'package:nutrigram/info_pages/heigh_weight.dart';
import 'package:nutrigram/info_pages/weekly_goals.dart';
import 'package:nutrigram/info_pages/workouts__info_page.dart';
import 'package:nutrigram/pages/home_page.dart';
import 'package:nutrigram/pages/nutrition_page.dart';
import 'package:nutrigram/pages/workout_page.dart';
import 'package:nutrigram/theme/app_color.dart';

class MultiPageForm extends StatefulWidget {
  @override
  _MultiPageFormState createState() => _MultiPageFormState();
}

class _MultiPageFormState extends State<MultiPageForm> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _validateCurrentPage(bool isValid) {
    setState(() {
      _pageValidations[_currentPage] = isValid;
    });
  }

  final List<Widget> _formPages = [];

  List<bool> _pageValidations = [false, false, false, true, false, false];

  final UserData user_data = UserData();

  final FirestoreServiceNutrition firestoreService =
      FirestoreServiceNutrition();

  void _goToNextPage() {
    if (_currentPage < _formPages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage >= 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _addWeeklyGoalsPage() {
    setState(() {
      if (!_formPages.any((page) => page is WeeklyGoalsPage)) {
        _formPages.add(
          WeeklyGoalsPage(
            user_data: user_data,
            onValidationChanged: _validateCurrentPage,
          ),
        );
        _pageValidations.add(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _formPages.addAll([
      GoalsPage(
        user_data: user_data,
        onValidationChanged: _validateCurrentPage,
        onAddWeeklyGoalsPage: _addWeeklyGoalsPage,
      ),
      WorkoutInfoPage(
        user_data: user_data,
        onValidationChanged: _validateCurrentPage,
      ),
      GenderPage(
        user_data: user_data,
        onValidationChanged: _validateCurrentPage,
      ),
      HeightWeightGoalPage(
        user_data: user_data,
        onValidationChanged: _validateCurrentPage,
      ),
      CalendarPage(
          user_data: user_data, onValidationChanged: _validateCurrentPage),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGray,
      appBar: AppBar(
        backgroundColor: AppColors.charcoalGray,
        leading: _currentPage != 0
            ? IconButton(
                onPressed: _goToPreviousPage,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
            : Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _formPages.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue.shade500
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // PageView to Display Pages
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _formPages,
            ),
          ),
          // Next Button
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
                width: double.infinity,
                height: 50,
                child: (_currentPage != (_formPages.length - 1))
                    ? ElevatedButton(
                        onPressed: _pageValidations[_currentPage]
                            ? _goToNextPage
                            : () {},
                        child: Text('NEXT',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: _pageValidations[_currentPage]
                              ? Colors.blue.shade500
                              : Colors.blue.shade200,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _pageValidations[_currentPage]
                            ? () {
                                if (user_data.goals == 'Bulk') {
                                  firestoreService.addUser(
                                      email: 'ngiamjw@gmail.com',
                                      recommendedNutrition:
                                          user_data.bulkCalculator(),
                                      userData: user_data.returnUserData());
                                } else if (user_data.goals == 'Cut') {
                                  firestoreService.addUser(
                                      email: 'ngiamjw@gmail.com',
                                      recommendedNutrition:
                                          user_data.cutCalculator(),
                                      userData: user_data.returnUserData());
                                } else if (user_data.goals == 'Lean Bulk') {
                                  firestoreService.addUser(
                                      email: 'ngiamjw@gmail.com',
                                      recommendedNutrition:
                                          user_data.leanbulkCalculator(),
                                      userData: user_data.returnUserData());
                                } else {
                                  firestoreService.addUser(
                                      email: 'ngiamjw@gmail.com',
                                      recommendedNutrition:
                                          user_data.maintainCalculator(),
                                      userData: user_data.returnUserData());
                                }
                                firestoreService.addDailyIntake(
                                    'ngiamjw@gmail.com',
                                    DateFormat('ddMMyyyy')
                                        .format(DateTime.now()),
                                    0,
                                    0,
                                    0,
                                    0);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              }
                            : () {},
                        child: Text('FINISH',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: _pageValidations[_currentPage]
                              ? Colors.blue.shade500
                              : Colors.blue.shade200,
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
