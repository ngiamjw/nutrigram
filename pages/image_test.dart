import 'package:flutter/material.dart';

class ImageGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Grid Example')),
      body: Center(
        child: SizedBox(
          height: 97,
          width: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Large square image on the left
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1, // Ensures the image is square
                  child: Image.network(
                    'https://via.placeholder.com/300', // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 4), // Spacing between left and right sections
              // Four smaller square images on the right
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // Top two images
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                'https://via.placeholder.com/150', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 4), // Spacing between images
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                'https://via.placeholder.com/150', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4), // Spacing between rows
                    // Bottom two images
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                'https://via.placeholder.com/150', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 4), // Spacing between images
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                'https://via.placeholder.com/150', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
