import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';
import '../widgets/custom_botton.dart';
import '../../services/resources_service.dart';
import '../resources/resource_screen.dart';
import 'add_resource.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  String value = '';
  List<Map<String, String>> resourcesData = [];
  List<Map<String, String>> allData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResourcesData('');
  }

  Future<void> _fetchResourcesData(String searchQuery) async {
    try {
      if (allData.isEmpty) {
        List<Map<String, String>> data =
            await ResourceService.fetchResourcesData();
        allData = data;
      }

      setState(() {
        resourcesData = _filterResources(allData, searchQuery);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching resources data: $e');
    }
  }

  List<Map<String, String>> _filterResources(
      List<Map<String, String>> allResources, String searchQuery) {
    if (searchQuery.isEmpty) {
      return allResources;
    }

    searchQuery = searchQuery.toLowerCase();

    return allResources.where((resource) {
      return resource['title']!.toLowerCase().contains(searchQuery) ||
          resource['specialty']!.toLowerCase().contains(searchQuery) ||
          resource['description']!.toLowerCase().contains(searchQuery);
    }).toList();
  }

  Future<void> _refreshResources() async {
    allData = await ResourceService.fetchResourcesData();
    setState(() {});
    resourcesData = allData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          "Resources",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                _fetchResourcesData(''); // Reset search
              },
              icon: const Icon(
                Icons.search,
                color: primaryColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('i am clicked');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddResourceForm()),
          );
          print('i am after clicked ');
        },
        backgroundColor: backcolor,
        child: const Icon(
          Icons.add,
          color: secondaryColor,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshResources,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      onChanged: (value) {
                        value = value;
                        _fetchResourcesData(value);
                      },
                      onSubmitted: (value) {
                        value = value;
                        _fetchResourcesData(value);
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        labelText: 'Search',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: backcolor2),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: backcolor2),
                        hintText: 'Enter search text',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: primaryColor,
                        ),
                        suffixIcon: value.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear,
                                    color: primaryColor),
                                onPressed: () {
                                  // Clear the search
                                  _fetchResourcesData('');
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: resourcesData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return _buildResourceCard(resourcesData[index]);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildResourceCard(Map<String, String> resource) {
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
                resource['title']!,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          Text(
            resource['description']!,
            style: const TextStyle(fontSize: 12),
            maxLines: 3, // Set the maximum number of lines to display
            overflow: TextOverflow.ellipsis, // Use ellipsis (...) for overflow
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Specialty: ${resource['specialty']!}",
            style: const TextStyle(fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align to the right
            children: [
              CustomButton(
                color: gradiant,
                padding: 0,
                height: 35,
                width: 100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResourceScreen(
                          resourceId: int.parse(resource['id']!)),
                    ),
                  );
                },
                text: "View",
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    (resource['rating'].toString() != 'null')
                        ? "${resource['rating'].toString()}"
                        : "/", // Assuming 'rating' is a String
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
