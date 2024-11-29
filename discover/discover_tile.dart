import 'package:flutter/material.dart';
import 'package:nutrigram/discover/add_comments_page.dart';
import 'package:nutrigram/discover/more_info_page.dart';
import 'package:nutrigram/discover/nutrition_row.dart';
import 'package:nutrigram/theme/app_color.dart';

class DiscoverTile extends StatelessWidget {
  final Map<String, dynamic> doc;
  const DiscoverTile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoreInfoPage(
                      doc: doc,
                    )),
          );
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile picture (circular)
                Padding(
                  padding: const EdgeInsets.all(8.0), // Add some padding
                  child: CircleAvatar(
                    radius: 30, // Size of the circular image
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Replace with your image URL
                    ),
                  ),
                ),
                SizedBox(width: 12), // Spacing between the image and text
                // Username and subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'chewenyu', // Username
                      style: TextStyle(
                        color: Colors.white, // White text for dark background
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4), // Space between username and subtitle
                    Text(
                      'Yesterday', // Subtitle
                      style: TextStyle(
                        color: Colors.grey, // Gray text for subtitle
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            NutritionRow(
                calories: doc['caloriesConsumed'],
                carbs: doc['carbsConsumed'],
                fats: doc['fatsConsumed'],
                protein: doc['proteinConsumed']),
            Divider(),
            SizedBox(
              height: 200, // Adjust the height of the carousel
              child: PageView.builder(
                controller: PageController(
                    viewportFraction: 0.55), // Adjust the viewport
                itemCount: doc['fooditems'].length,
                physics:
                    PageScrollPhysics(), // Ensures snapping to the next image
                itemBuilder: (context, index) {
                  return Center(
                    // Center the container in the viewport
                    child: Container(
                      width: 200, // Fixed width for each image
                      margin: EdgeInsets.symmetric(
                          horizontal: 10), // Space between images
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 3), // Shadow offset
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20), // Same as the decoration
                        child: Image.network(
                          doc['fooditems'][index]['imageURL'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Discover more',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0 likes',
                  style: TextStyle(color: Colors.grey),
                ),
                Text('0 comments', style: TextStyle(color: Colors.grey))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.thumb_up_alt_outlined),
                VerticalDivider(
                  width: 1, // Width of the divider space
                  thickness: 2, // Thickness of the divider line
                  color: Colors.grey, // Color of the divider
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCommentsPage()),
                      );
                    },
                    child: Icon(Icons.comment_outlined)),
                VerticalDivider(
                  width: 1, // Width of the divider space
                  thickness: 2, // Thickness of the divider line
                  color: Colors.grey, // Color of the divider
                ),
                Icon(Icons.share_arrival_time_outlined),
              ],
            )
          ],
        ),
      ),
    );
  }
}
