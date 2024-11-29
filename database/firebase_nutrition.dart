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

  Future<void> addDailyIntake(String email, String date) async {
    final dailyIntakeRef =
        nutrition.doc(email).collection('dailyIntake').doc(date);
    final snapshot = await dailyIntakeRef.get();

    if (!snapshot.exists) {
      // Add daily intake if the document does not exist
      await dailyIntakeRef.set({
        'date': date,
        'caloriesConsumed': 0,
        'proteinConsumed': 0,
        'carbsConsumed': 0,
        'fatsConsumed': 0,
        'fooditems': [],
        'likes': 0,
        'comments': [],
      });

      print("Daily intake added successfully for $date");
    } else {
      print("Daily intake for $date already exists. No changes made.");
    }
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

  Future<void> addComment(
      String email, String date, String content, String comment_email) {
    final dailyIntakeRef =
        nutrition.doc(email).collection('dailyIntake').doc(date);
    Map<String, dynamic> comment = {
      'content': content,
      'comment_email': comment_email,
    };
    return dailyIntakeRef.update({
      'comments': FieldValue.arrayUnion([comment])
    });
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

    final dailyIntakeRef =
        nutrition.doc(email).collection('dailyIntake').doc(date);

    Map<String, dynamic> foodItem = {
      'foodName': foodName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'imageURL': imageUrl,
      'timestamp': Timestamp.now(),
    };

    return dailyIntakeRef.update({
      'caloriesConsumed': daily_calories + calories,
      'proteinConsumed': daily_protein + protein,
      'carbsConsumed': daily_carbs + carbs,
      'fatsConsumed': daily_fats + fats,
      'fooditems': FieldValue.arrayUnion([foodItem])
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

  Future<List<Map<String, dynamic>>> getDocumentsWithFoodItems(
      String email) async {
    List<Map<String, dynamic>> filteredDocuments = [];

    try {
      final firestore = FirebaseFirestore.instance;
      final dailyIntakeRef = firestore
          .collection('nutrition')
          .doc(email)
          .collection('dailyIntake');

      DateTime now = DateTime.now();

      for (int i = 0; i < 7; i++) {
        DateTime date = now.subtract(Duration(days: i));
        String formattedDate = "${date.day.toString().padLeft(2, '0')}"
            "${date.month.toString().padLeft(2, '0')}"
            "${date.year}";

        DocumentSnapshot docSnapshot =
            await dailyIntakeRef.doc(formattedDate).get();

        if (docSnapshot.exists) {
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;
          if (data.containsKey('fooditems') &&
              data['fooditems'] is List &&
              (data['fooditems'] as List).isNotEmpty) {
            // Include only documents where fooditems exist and are not empty
            filteredDocuments.add({
              'date': formattedDate,
              ...data, // Spread the document's fields
            });
          }
        }
      }

      return filteredDocuments;
    } catch (e) {
      print("Error fetching documents: $e");
      return [];
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
