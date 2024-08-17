import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../screens/widgets/custom_botton.dart';
import '../widgets/app_bar.dart';
import '../../services/resources_service.dart';
import '../resourceBookmark.dart';

class ResourceScreen extends StatefulWidget {
  final int resourceId;

  const ResourceScreen({Key? key, required this.resourceId}) : super(key: key);

  @override
  _ResourceScreenState createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  late Future<Map<String, dynamic>> _resourceData;

  @override
  void initState() {
    super.initState();
    _resourceData = ResourceService.fetchResourceData(widget.resourceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniAppBar(appTitle: "Resource Details"),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _resourceData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  buildResourceUI(
                    snapshot.data!['title'],
                    snapshot.data!['description'],
                    snapshot.data!['attachments'],
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          padding: 0,
                          height: 40,
                          width: 90,
                          onTap: () {
                            showRatingModal(context);
                          },
                          text: "Rate",
                        ),
                        CustomButton(
                          padding: 0,
                          height: 40,
                          width: 180,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                int resource = widget.resourceId;
                                return BookmarkPage(
                                    collectionType: 'resource',
                                    resourceId: resource);
                              },
                            );
                          },
                          text: "Add to Collection",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildResourceUI(
    String title,
    String description,
    List<Map<String, String>> attachments,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Text(
              description,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Column(
            children: [
              for (Map<String, String> attachment in attachments)
                GestureDetector(
                  onTap: () {
                    openResource(attachment['url']!);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          Colors.lightBlue[100], // Light blue background color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            attachment['fileName']!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  void openResource(String resourceUrl) async {
    if (!await launchUrl(Uri.parse(resourceUrl))) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not open the resource'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

// In your _ResourceScreenState class
  void showRatingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double userRating = 3; // Initialize with a default value
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rate this resource',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 36,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  userRating = rating;
                },
              ),
              SizedBox(height: 16),
              CustomButton(
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    // Call the service function to submit the rating
                    await ResourceService.submitRating(
                      widget.resourceId,
                      userRating,
                    );
                    // Perform any additional actions after submitting the rating
                    // For example, update the UI to reflect the new rating
                  } catch (e) {
                    // Handle error (display an error message, etc.)
                    print('Error submitting rating: $e');
                  }
                },
                text: 'Submit Rating',
              ),
            ],
          ),
        );
      },
    );
  }
}
