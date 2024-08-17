import 'package:flutter/material.dart';
import 'package:unimate/screens/groups/create_group.dart';
import 'widgets/group_widget_card.dart';
import '../../core/utils/app_imports.dart';
import '../../services/Group_service.dart';


class GroupesScreen extends StatefulWidget {
  const GroupesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GroupesScreenState createState() => _GroupesScreenState();
}

class _GroupesScreenState extends State<GroupesScreen> {

  
  

  int currentindex=2;
  Future<Map<String, Map<String, dynamic>>> _groupsFuture = Future.value({});
  Future<Map<String, Map<String, dynamic>>> _suggestedgroups = Future.value({});
  @override
  void initState() {
    super.initState();
    _groupsFuture =  Group.getmygroups();
    _suggestedgroups = Group.getSuggestedGroup();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _groupsFuture = Group.getmygroups();
    });
  }
    Future<void> _refreshsuggestedPosts() async {
    setState(() {
      _suggestedgroups = Group.getSuggestedGroup();
    });
  }
  final ScrollController _scrollController = ScrollController();

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Groups',
          style: TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Unicons.edit,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateGroupTap(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  labelText: 'Search',
                  labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: backcolor2),
                  hintText: 'Enter search text',
                  hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: backcolor2),
                  prefixIcon: const Icon(Icons.search, color: primaryColor, ),
                  suffixIcon: const Icon(Icons.filter_alt_rounded, color: primaryColor,),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Three Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  buildButton("Your Groups", 2),
                  buildButton("Suggestions", 3),
                ],
              ),
     
     if (currentindex == 2) ...{
      yourGroups(),
    } else ...{
      suggestionsSection(),
    },
   
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildButton(String listName, int index) {
  return ElevatedButton(
    onPressed: () {
      setState(() {
        currentindex = index;
      });
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: backcolor,
      foregroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(listName),
  );
}

  // Replace your existing buildInvitationsList(), buildYourGroupsList(), and buildSuggestionsList() functions with the following:
  Widget buildYourGroupsList() {
    return RefreshIndicator(
      onRefresh: _refreshPosts,
      child:FutureBuilder<Map<String,Map<String, dynamic>>>(
  future: _groupsFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Return a loading indicator while waiting for the data.
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      // Handle error state.
      return Text('Error: ${snapshot.error}');
    } else {
      
      // Data has been retrieved successfully.
      Map<String,Map<String, dynamic>> groups = snapshot.data!;
      
      return ListView.builder(
  controller: _scrollController,
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemCount: groups.length,
  itemBuilder: (context, index) {
    // Get the key (group ID) for the current group
    String groupId = groups.keys.elementAt(index);
    
    // Access the properties for the current group using the group ID
    Map<String, dynamic> groupData = groups[groupId]!;
    String specialty = groupData['Specialty'];
    String name = groupData['Name'];
    String url = groupData['url_image'];
    String id =groupId;

    // Return a GroupCard widget with the retrieved information
    return GroupCard(
      specialty: specialty,
      name: name,
      url: url,
      id:id,
      join:0

    );
  },
);

    }
  },
) ) ;

  }
  Widget buildSuggestionsList() {
   return RefreshIndicator(
      onRefresh: _refreshsuggestedPosts,
      child:FutureBuilder<Map<String,Map<String, dynamic>>>(
  future: _suggestedgroups,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Return a loading indicator while waiting for the data.
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      // Handle error state.
      return Text('Error: ${snapshot.error}');
    } else {
      
      // Data has been retrieved successfully.
      Map<String,Map<String, dynamic>> groups = snapshot.data!;
      
      return ListView.builder(
  controller: _scrollController,
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemCount: groups.length,
  itemBuilder: (context, index) {
    // Get the key (group ID) for the current group
    String groupId = groups.keys.elementAt(index);
    
    // Access the properties for the current group using the group ID
    Map<String, dynamic> groupData = groups[groupId]!;
    String specialty = groupData['Specialty'];
    String name = groupData['Name'];
    String url = groupData['url_image'];
    String id =groupId;
    

    // Return a GroupCard widget with the retrieved information
    return GroupCard(
      specialty: specialty,
      name: name,
      url: url,
      id:id,
      join:1

    );
  },
);

    }
  },
) ) ;

  }

Widget yourGroups() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Text(
          "Your Groups",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        buildYourGroupsList(),
      ],
    ),
  );
}

Widget suggestionsSection() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Suggestions",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
        ),
      ),
      buildSuggestionsList(),
    ],
  );
}

}
