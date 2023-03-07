import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

class ExampleSlide extends SlideWidget {
  const ExampleSlide({
    super.key,
    this.text,
    this.backgroundColor,
  });

  final String? text;

  final Color? backgroundColor;

  @override
  Widget? background() {
    return (backgroundColor == null)
        ? null
        : Container(
            color: backgroundColor,
          );
  }

  @override
  Widget slide(BuildContext context) {
    return Center(
      child: Text(
        text ?? 'The Title',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
