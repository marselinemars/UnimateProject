import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import 'widgets/specialty_info_section.dart';
import 'widgets/specialty_info_bottom.dart';
import 'widgets/specialty_info_top.dart';

class SpecialtyInfo extends StatefulWidget {
  const SpecialtyInfo({super.key});

  @override
  _SpecialtyInfoState createState() => _SpecialtyInfoState();
}

class _SpecialtyInfoState extends State<SpecialtyInfo> {
  // Add your state variables here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const UniAppBar(appTitle: 'Specialty info '),
        backgroundColor: Colors.white,
        body: DefaultTabController(
            length: 2,
            child: ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SpecialtyInfoTop();
                  } else if (index == 24) {
                    return const CommentPageSpecialty();
                  } else {
                    return SpecialtyInfoSection(
                        index: index - 1,
                        info:
                            ''' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tristique, quam vitae varius varius, felis elit commodo odio, vel efficitur urna sapien vel sapien. Vivamus vel neque in elit sollicitudin malesuada. Proin aliquam arcu id ligula malesuada, nec eleifend metus accumsan. Curabitur sit amet neque vel turpis tincidunt rhoncus. Integer vestibulum bibendum lectus, in pellentesque augue tristique id. Aenean at libero ac lectus pellentesque fermentum. Sed vel ipsum nec ligula dapibus dignissim. Suspendisse non metus vitae urna consequat laoreet. Vivamus tincidunt ultrices purus, a vestibulum orci efficitur nec. Integer quis tortor ut urna pharetra bibendum. Quisque consequat libero a purus fermentum, id fringilla sapien consectetur. Curabitur nec justo at velit scelerisque laoreet.''');
                  }
                })));
  }
}
