import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ImageCards extends StatefulWidget {
  const ImageCards({
    Key? key,
    required this.foregroundImages,
    required this.backgroundImages,
    required this.texts,
  }) : super(key: key);

  final List<String> foregroundImages;
  final List<String> backgroundImages;
  final List<String> texts;

  @override
  State<ImageCards> createState() => _ImageCardsState();
}

class _ImageCardsState extends State<ImageCards> {
  double? _accelerometerXAxis;
  late final StreamSubscription<dynamic> _streamSubscription;

  late final List<String> _foregroundImages;
  late final List<String> _backgroundImages;
  late final List<String> _texts;

  @override
  void initState() {
    super.initState();
    _foregroundImages = widget.foregroundImages;
    _backgroundImages = widget.backgroundImages;
    _texts = widget.texts;

    _streamSubscription = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerXAxis = event.x;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.9,
        viewportFraction: 0.90,
        enableInfiniteScroll: false,
      ),
      items: _foregroundImages.asMap().entries.map((entry) {
        int index = entry.key;
        String foregroundImage = entry.value;

        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      right: _accelerometerXAxis != null
                          ? (-350 + _accelerometerXAxis! * 30)
                          : -350,
                      left: _accelerometerXAxis != null
                          ? (-350 + _accelerometerXAxis! * 30)
                          : -350,
                      top: _accelerometerXAxis != null
                          ? (-350 + _accelerometerXAxis! * 30)
                          : -350,
                      bottom: _accelerometerXAxis != null
                          ? (-350 + _accelerometerXAxis! * 30)
                          : -350,
                      child: Image.asset(
                        _backgroundImages[index],
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      width: 320,
                      bottom: 0,
                      right: _accelerometerXAxis != null
                          ? (-13 + _accelerometerXAxis! * 1.5)
                          : -13,
                      child: Image.asset(
                        foregroundImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 60),
                        Text(
                          'FEATURED',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          _texts[index], //GabrielaStencil
                          style: GoogleFonts.gabriela(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
