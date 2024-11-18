class WorkoutData {
  Duration duration;
  List<ExerciseData> exercises;
  int totalSets;
  int volume; // Placeholder for future volume calculations
  int records; // Placeholder for future records data

  WorkoutData({
    this.duration = const Duration(seconds: 0),
    List<ExerciseData>? exercises,
    this.totalSets = 0,
    this.volume = 0,
    this.records = 0,
  }) : exercises = exercises ?? [];

  void addExercise(ExerciseData exercise) {
    exercises.add(exercise);
    updateTotalSets();
  }

  Map<String, dynamic> toMap() {
    return {
      'duration': duration.inSeconds, // Store duration as seconds
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
      'totalSets': totalSets,
      'volume': volume,
      'records': records,
    };
  }

  void updateTotalSets() {
    totalSets =
        exercises.fold(0, (sum, exercise) => sum + exercise.sets.length);
  }

  void removeExercise(int index) {
    if (index >= 0 && index < exercises.length) {
      exercises.removeAt(index);
      updateTotalSets(); // Update the total set count after removing
    }
  }

  void clearWorkout() {
    duration = Duration(seconds: 0);
    exercises.clear();
    totalSets = 0;
    volume = 0;
    records = 0;
  }
}

class ExerciseData {
  String exerciseName;
  List<WorkoutSet> sets;
  String notes;

  ExerciseData(
      {required this.exerciseName, required this.sets, this.notes = ''});

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'notes': notes,
      'sets': sets.map((set) => set.toMap()).toList(),
    };
  }

  void addSet() {
    sets.add(WorkoutSet(setNumber: sets.length + 1));
  }

  void removeSet(int index) {
    if (index >= 0 && index < sets.length) {
      sets.removeAt(index);
      _updateSetNumbers(); // Ensure the set numbers are updated correctly
    }
  }

  void clearData() {
    exerciseName = '';
    sets.clear();
    notes = '';
  }

  void _updateSetNumbers() {
    for (int i = 0; i < sets.length; i++) {
      sets[i].setNumber = i + 1; // Update set numbers to maintain order
    }
  }
}

class WorkoutSet {
  int setNumber;
  int reps;
  bool completed;

  WorkoutSet({required this.setNumber, this.reps = 0, this.completed = false});

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
      'reps': reps,
      'completed': completed,
    };
  }
}
