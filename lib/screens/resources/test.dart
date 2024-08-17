import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';
import '../widgets/custom_botton.dart';

class ResourcesPage2 extends StatefulWidget {
  const ResourcesPage2({Key? key}) : super(key: key);

  @override
  State<ResourcesPage2> createState() => _ResourcesPageState2();
}

class _ResourcesPageState2 extends State<ResourcesPage2> {
  late Stream<List<Map<String, dynamic>>> resourcesStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream with an empty list
    resourcesStream = Stream.value([]);
    // Fetch resources and update the stream
    fetchResources();
  }

  Future<void> fetchResources() async {
    // Simulating resource fetching, replace this with your actual API call
    await Future.delayed(Duration(seconds: 2));

    // Dummy resource data
    List<Map<String, dynamic>> dummyData = [
      {
        'title': 'Td algebra: matrices',
        'description':
            'Some description of this great resource in matrices and their applications',
        'specialty': 'Artificial Intelligence',
        'type': 'pdf',
      },
      // Add more resources as needed
    ];

    // Update the stream with the new resources
    resourcesStream = Stream.value(dummyData);
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text("Resources",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              decoration: InputDecoration(
                  // Your search bar decoration
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: resourcesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while waiting for resources
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Error loading resources: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Display a message when no resources are available
                  return Center(child: Text('No resources available'));
                } else {
                  // Display the resources
                  return buildResourcesList(snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResourcesList(List<Map<String, dynamic>> resources) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: resources.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        // Display the resource
        return buildResourceItem(resources[index]);
      },
    );
  }

  Widget buildResourceItem(Map<String, dynamic> resource) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                resource['title'],
                style: const TextStyle(fontSize: 14),
              ),
              Icon(Icons.add),
            ],
          ),
          Text(
            resource['description'],
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Specialty",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    resource['specialty'],
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Type:",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    resource['type'],
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              )
            ],
          ),
          CustomButton(
            color: gradiant,
            padding: 0,
            height: 35,
            width: 100,
            onTap: () {
              Navigator.pushNamed(context, '/resource');
            },
            text: "View",
          ),
        ],
      ),
    );
  }
}
