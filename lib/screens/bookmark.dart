import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';
import 'widgets/custom_botton.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<String> selectedCollections = []; // List to hold selected collections

  List<String> collections = [
    'Collection 1',
    'Collection 2',
    'Collection 3',
    'Collection 4',
    // Add more collections as needed
  ];

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Save to collection",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),
                ),
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
          Text("Your collections",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)),
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
                final collection = collections[index];
                final bool isSelected =
                    selectedCollections.contains(collection);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCollections.remove(collection);
                      } else {
                        selectedCollections.add(collection);
                      }
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    color: isSelected ? secondaryColor : gray,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Center(
                            child: Text(
                              collection,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,color: primaryColor
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null && value) {
                                  selectedCollections.add(collection);
                                } else {
                                  selectedCollections.remove(collection);
                                }
                              });
                            },
                          ),
                        ),
                      ],
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

  void _showCollectionSelection(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Collection"),
          content: TextField(
            controller: textFieldController,
            decoration:
                const InputDecoration(hintText: "Enter collection name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  collections.insert(
                      0, textFieldController.text); // Add at the first index
                  textFieldController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                textFieldController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}