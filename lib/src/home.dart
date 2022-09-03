import 'package:flutter/material.dart';
import 'package:motion_images/res/images/images.dart';
import 'package:motion_images/src/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('3D Image'),
      // ),
      body: Center(
        child: ImageCards(
          foregroundImages: foregroundImages,
          backgroundImages: backgroundImage,
          texts: charactersName,
        ),
      ),
    );
  }
}
