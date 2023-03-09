import 'package:flutter/material.dart';
import 'package:prides/prides.dart';
import './content/content.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PresentationWidget(
        background: const ColoredBox(
          color: Color.fromARGB(255, 113, 61, 173),
        ), // a one color background for whole presentation
        slides: [
          const CustomTitleSlide(), // slide in content/title_slide.dart
          const TitleSlide(
            title: Text('Title Slide'),
            subtitle: Text('This is a templete slide'),
          ),
          const TitleSlide.fromText(
            title: 'Title Slide',
            subtitle: 'This is a templete slide using fromText()',
          ),
          const ExampleSlide(
            text: 'Slide with no background',
          ), // custom slide with no background
          const ExampleSlide(
            text: 'Slide with a background color',
            backgroundColor: Color.fromARGB(255, 30, 114, 184),
          ),
          const SimpleSlide(
            slide: Text('This is a SimpleSlide without background.'),
          ), // usage of SimpleSlide that comes with the package
          SimpleSlide(
            slide: const Text('This is a SimpleSlide with background'),
            background:
                Container(color: const Color.fromARGB(255, 90, 155, 180)),
          ),
          const CounterSlide(),
          const ExampleSlide(
            text: 'Flutter is Awesome!',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
