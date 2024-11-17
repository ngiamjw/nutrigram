import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/camera/image_details_page.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  final int daily_calories;
  final int daily_protein;
  final int daily_carbs;
  final int daily_fats;

  CameraScreen(
      {super.key,
      required this.daily_calories,
      required this.daily_carbs,
      required this.daily_fats,
      required this.daily_protein});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  final ImagePicker _picker = ImagePicker();

  bool isphototaken = false;

  final jsonSchema = Schema.object(
    properties: {
      'name': Schema.string(),
      'calories': Schema.integer(),
      'protein': Schema.integer(),
      'carbs': Schema.integer(),
      'fats': Schema.integer(),
    },
  );

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initializeCamera();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.high, // You can adjust the resolution here
      );

      await _cameraController?.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> uploadImage(File pickedFile) async {
    // Convert XFile to File using the file path
    final File imageFile = File(pickedFile.path);

    // Read the image bytes from the File
    final image = await imageFile.readAsBytes();

    // Create InlineDataPart using the image bytes
    final InlineDataPart imagePart = InlineDataPart(
      'image/jpeg', // MIME type of the image
      image, // Image data in bytes
    );
    final model = FirebaseVertexAI.instance.generativeModel(
        model: 'gemini-1.5-flash', // Replace with your model name
        generationConfig: GenerationConfig(
            responseMimeType: 'application/json', // Specify JSON response
            responseSchema: jsonSchema));

    final prompt =
        "The image is a dish. Give me the name of the dish and its nutrition contents, calories, protein, carbs and fats. [IMAGE]";

    final contentList = [
      Content.text(prompt),
      Content.multi([imagePart])
    ];

    final response = await model.generateContent(contentList);

    // Process the generated structured response (JSON format)
    final Map<String, dynamic> responseMap = jsonDecode(response.text!);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageDetailsPage(
                image: imageFile,
                response: responseMap,
                daily_calories: widget.daily_calories,
                daily_carbs: widget.daily_carbs,
                daily_fats: widget.daily_fats,
                daily_protein: widget.daily_protein,
              )),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _openGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the picked image
      final File imageFile = File(pickedFile.path);
      setState(() {
        isphototaken = true;
      });
      uploadImage(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        isphototaken) {
      return Center(
          child: CircularProgressIndicator(
        color: Colors.blue.shade500,
      ));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Ensure the camera preview takes the entire screen
          Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: _cameraController!.value.aspectRatio,
                  child: CameraPreview(_cameraController!),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.blue.shade500, size: 30),
              onPressed: () {
                Navigator.pop(context); // Close the camera screen
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.folder, color: Colors.blue.shade500, size: 30),
              onPressed: _openGallery, // Open gallery to pick an image
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FloatingActionButton(
                backgroundColor: Colors.blue.shade500,
                onPressed: () async {
                  try {
                    if (_cameraController != null &&
                        _cameraController!.value.isInitialized) {
                      final XFile image =
                          await _cameraController!.takePicture();

                      final File imageFile = File(image.path);
                      setState(() {
                        isphototaken = true;
                      });

                      uploadImage(imageFile);

                      // Handle the captured image
                    }
                  } catch (e) {
                    print('Error taking picture: $e');
                  }
                },
                child: Icon(Icons.camera_alt_rounded, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
