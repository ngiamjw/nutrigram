import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrigram/workout_pages/workout_data.dart';

class firestoreServiceWorkout {
  final CollectionReference workout =
      FirebaseFirestore.instance.collection('workout');

  //ADD
  Future<void> uploadWorkoutData(
      String email, WorkoutData workoutData, String date) async {
    try {
      // Create a document in Firestore
      final user = workout.doc(email).collection(date).doc();
      await user.set(workoutData.toMap());

      print("Workout uploaded successfully!");
    } catch (e) {
      print("Failed to upload workout: $e");
    }
  }

  //READ
  Future<List<Map<String, dynamic>>> getWorkoutData(
      String email, String date) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's workout data for the given date
      CollectionReference workoutCollection =
          firestore.collection('workout').doc(email).collection(date);

      // Get all workout documents for the specific date
      QuerySnapshot querySnapshot = await workoutCollection.get();

      // Convert each document to a Map
      List<Map<String, dynamic>> workouts = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return workouts;
    } catch (e) {
      print("Failed to retrieve workout: $e");
      return [];
    }
  }
}
