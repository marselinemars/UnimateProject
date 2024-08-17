import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../core/utils/app_imports.dart';

class UniInfoTop extends StatefulWidget {
  const UniInfoTop({super.key});

  @override
  State<UniInfoTop> createState() => _UniInfoTopState();
}

class _UniInfoTopState extends State<UniInfoTop> {
  final double latitude = 37.7749; // Replace with the desired latitude
  final double longitude = -122.4194; // Replace with the desired longitude
  bool isFavorite = false;

  Future<void> _openMap(double lat, double long) async {
    if (await MapLauncher.isMapAvailable(MapType.google) != null) {
      await MapLauncher.showMarker(
          mapType: MapType.google,
          coords: Coords(lat, long),
          title: 'the university location ');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: height * 0.4,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: width,
                    height: height * 0.4 - width * 0.07,
                    child: Image.asset(
                      'assets/images/ensia.png',
                      fit: BoxFit.fill,
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  right: width * 0.03,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: greyWhite),
                    width: width * 0.14,
                    height: width * 0.14,
                    child: IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: secondaryColor,
                      ),
                      onPressed: () {},
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  right: width * 0.18,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: greyWhite),
                    width: width * 0.14,
                    height: width * 0.14,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: secondaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  right: width * 0.33,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: greyWhite),
                    width: width * 0.14,
                    height: width * 0.14,
                    child: IconButton(
                      icon: const Icon(
                        Icons.location_on,
                        color: secondaryColor,
                      ),
                      onPressed: () {
                        _openMap(latitude, longitude);
                      },
                    ),
                  )),
              Positioned(
                  top: width * 0.02,
                  left: width * 0.02,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greyWhite),
                    width: width * 0.10,
                    height: width * 0.10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: secondaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 20),
          child:  Text(
            'Higher national school of artificial intelligence (ENSIA)',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: primaryColor),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
