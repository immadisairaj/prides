import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

class CustomTitleSlide extends SlideWidget {
  const CustomTitleSlide({super.key});

  @override
  Widget? background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 244, 67, 54), // red
            Color.fromARGB(255, 33, 150, 243), // blue
            Color.fromARGB(255, 63, 81, 181), // indigo
            Color.fromARGB(255, 63, 81, 181), // indigo
            Color.fromARGB(255, 33, 150, 243), // blue
            Color.fromARGB(255, 244, 67, 54), // red
          ],
        ),
      ),
    );
  }

  @override
  Widget slide(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hello Prides!',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'This is a slide using gradient background',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Press `->` (right arrow) or tap to move to the next slide',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
