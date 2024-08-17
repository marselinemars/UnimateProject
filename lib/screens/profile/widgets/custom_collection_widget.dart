import 'package:unimate/screens/profile/profile.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_imports.dart';


class CustomCollectionItemWidget extends StatefulWidget {
  const CustomCollectionItemWidget({Key? key, this.showUser = false,this.collectionName="Analyis"}) : super(key: key);
  final bool showUser;
  final String collectionName;

  @override
  State<CustomCollectionItemWidget> createState() =>
      _CustomCollectionItemWidgetState();
}

class _CustomCollectionItemWidgetState extends State<CustomCollectionItemWidget> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and profail picture
          widget.showUser == true
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileTap(
                                showFollowBottomInProfile: true,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            "assets/images/pic1.png",
                            height: 32,
                            width: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Calum Lewis",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),

          // Collection image and favorite botton
          Stack(
            children: [
              //Collection image
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {/*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CollectionItemScreen()));
                    */},
                    child: Image.asset(
                      "assets/images/ensia.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Favorite botton
            
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 255, 255, 255), // Use your desired color
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 119, 116, 116), // Use your desired color
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey, // Use your desired color
                      ),
                    ),
                  ],
                ),
                      ),
                
                
                  
              
            ],
          ),

          // Collection name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.collectionName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color :primaryColor),
            ),
          ),
         
        ],
      ),
    );
  }
}
