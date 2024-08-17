import 'package:flutter/material.dart';
import 'widgets/custom_botton.dart';
import '../services/resources_service.dart';

class BookmarkPage extends StatefulWidget {
  final String collectionType; // Parameter to specify collection type
  final int resourceId;

  BookmarkPage(
      {super.key, required this.collectionType, required this.resourceId});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late Future<Map<String, String>> futureCollections;
  Set<String> selectedCollectionIds = Set<String>();

  @override
  void initState() {
    super.initState();
    futureCollections = _fetchCollectionsFromBackend(widget.collectionType);
  }

  Future<Map<String, String>> _fetchCollectionsFromBackend(String type) async {
    // Dummy backend call to fetch collections of a specific type
    Map<String, String> CollectionData =
        await ResourceService.fetchResourceCollections();
    return CollectionData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: futureCollections,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No collections available'));
        } else {
          return _buildCollectionsView(snapshot.data!);
        }
      },
    );
  }

  Widget _buildCollectionsView(Map<String, String> collections) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    padding: 0,
                    height: 40,
                    width: 150,
                    onTap: () {
                      print('i am called ');
                      print(selectedCollectionIds);
                      _submitSelection();

                      Navigator.pop(context);
                      _showSuccessDialog(context);
                    },
                    text: "Save "),
                CustomButton(
                    padding: 0,
                    height: 40,
                    width: 150,
                    onTap: () {
                      _showCollectionSelection(context);
                    },
                    text: "New Collection"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: collections.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                String collectionId = collections.keys.elementAt(index);
                String collectionName = collections[collectionId]!;
                final bool isSelected =
                    selectedCollectionIds.contains(collectionId);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCollectionIds.remove(collectionId);
                      } else {
                        selectedCollectionIds.add(collectionId);
                      }
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    color: isSelected ? Colors.blue : Colors.white,
                    child: Center(
                      child: Text(
                        collectionName,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("resource is saved successfully!"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _submitSelection() async {
    print('the function is called here ');
    await ResourceService.sendSelectedCollectionIdsToBackend(
        selectedCollectionIds, widget.resourceId);
  }

  Future<bool> _uploadNewCollectionToBackend(
      String collectionName, String type) async {
    await ResourceService.AddNewCollectionToBackend(collectionName);
    return true;
  }

  void _showCollectionSelection(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New ${widget.collectionType} Collection"),
          content: TextField(
            controller: textFieldController,
            decoration:
                const InputDecoration(hintText: "Enter collection name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Add"),
              onPressed: () async {
                if (textFieldController.text.isNotEmpty) {
                  // Replace this with actual backend call
                  bool success = await _uploadNewCollectionToBackend(
                      textFieldController.text, widget.collectionType);
                  if (success) {
                    // Refetch collections from the backend
                    setState(() {
                      futureCollections =
                          _fetchCollectionsFromBackend(widget.collectionType);
                    });
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
