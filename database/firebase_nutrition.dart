import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreServiceNutrition {
  //get collection of users
  final CollectionReference nutrition =
      FirebaseFirestore.instance.collection('nutrition');

  //CREATE

  Future<void> addUser(
      {required String email,
      required Map<String, dynamic> recommendedNutrition,
      required Map<String, dynamic> userData}) {
    // Use the email as the document ID
    return nutrition.doc(email).set({
      'recommendedNutrition': recommendedNutrition,
      'user_info': userData,
    });
  }

  Future<void> addDailyIntake(String email, String date, int calories,
      int protein, int carbs, int fats) {
    final dailyIntakeRef =
        nutrition.doc(email).collection('dailyIntake').doc(date);

    return dailyIntakeRef.set({
      'date': date,
      'caloriesConsumed': calories,
      'proteinConsumed': protein,
      'carbsConsumed': carbs,
      'fatsConsumed': fats,
    });
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('food_images/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile);
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> saveFoodItem(
      String email,
      String date,
      String foodName,
      int calories,
      int protein,
      int carbs,
      int fats,
      File imageFile,
      int daily_calories,
      int daily_protein,
      int daily_carbs,
      int daily_fats) async {
    String imageUrl = await uploadImage(imageFile);

    final foodItemsRef = nutrition
        .doc(email)
        .collection('dailyIntake')
        .doc(date)
        .collection('foodItems')
        .doc();

    await foodItemsRef.set({
      'foodName': foodName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'imageURL': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });

    final dailyIntakeRef =
        nutrition.doc(email).collection('dailyIntake').doc(date);

    return dailyIntakeRef.update({
      'caloriesConsumed': daily_calories,
      'proteinConsumed': daily_protein,
      'carbsConsumed': daily_carbs,
      'fatsConsumed': daily_fats,
    });
  }

  //READ
  Future<List<Map<String, dynamic>>> getFoodItems(
      String email, String date) async {
    final foodItemsSnapshot = await nutrition
        .doc(email)
        .collection('dailyIntake')
        .doc(date)
        .collection('foodItems')
        .get();

    return foodItemsSnapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<DocumentSnapshot> getUserStream(String email) {
    return nutrition.doc(email).snapshots();
  }

  Future<Map<String, dynamic>> getDailyIntake(String email, String date) async {
    try {
      DocumentSnapshot dailyIntakeDoc =
          await nutrition.doc(email).collection('dailyIntake').doc(date).get();

      if (dailyIntakeDoc.exists) {
        return dailyIntakeDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception("No daily intake found for this date");
      }
    } catch (e) {
      print("Error retrieving daily intake: $e");
      return {};
    }
  }

  //UPDATE
  Future<void> updateUserInfo(
      {required String email, required Map<String, dynamic> userData}) {
    // Use the email as the document ID
    return nutrition.doc(email).update({
      'user_info': userData,
    });
  }

  //DELETE
}
