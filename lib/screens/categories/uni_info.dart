import 'package:flutter/material.dart';
import 'widgets/uni_info_bottom.dart';
import 'widgets/uni_info_section.dart';
import 'widgets/uni_info_top.dart';

class UniInfo extends StatefulWidget {
  const UniInfo({super.key});

  @override
  _UniInfoState createState() => _UniInfoState();
}

class _UniInfoState extends State<UniInfo> {
  // Add your state variables here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
            length: 2,
            child: ListView.builder(
                itemCount: 23,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const UniInfoTop();
                  }
                  if (index == 22) {
                    return const UniInfoBottom();
                  } else {
                    return UniInfoSection(
                        index: index - 1,
                        info:
                            ''' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tristique, quam vitae varius varius, felis elit commodo odio, vel efficitur urna sapien vel sapien. Vivamus vel neque in elit sollicitudin malesuada. Proin aliquam arcu id ligula malesuada, nec eleifend metus accumsan. Curabitur sit amet neque vel turpis tincidunt rhoncus. Integer vestibulum bibendum lectus, in pellentesque augue tristique id. Aenean at libero ac lectus pellentesque fermentum. Sed vel ipsum nec ligula dapibus dignissim. Suspendisse non metus vitae urna consequat laoreet. Vivamus tincidunt ultrices purus, a vestibulum orci efficitur nec. Integer quis tortor ut urna pharetra bibendum. Quisque consequat libero a purus fermentum, id fringilla sapien consectetur. Curabitur nec justo at velit scelerisque laoreet.''');
                  }
                })));
  }
}
