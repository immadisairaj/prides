import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

final SlideController _controller = SlideController();

class CounterSlide extends SlideWidget {
  const CounterSlide({super.key});

  @override
  SlideController? get controller => _controller;

  @override
  Widget? background() => const SizedBox.shrink();

  @override
  Widget slide(BuildContext context) =>
      MyHomePage(title: 'Counter', controller: _controller);
}

class MyHomePage extends StatefulWidget {
  final String title;
  final SlideController controller;

  const MyHomePage({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements SlideControllerListener {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(this);
    _counter = 0;
  }

  @override
  void dispose() {
    widget.controller.removeListener();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'This slide will advance only when the counter reaches 6 '
              'and will reverse only when the counter is back to 0',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool onAdvanceSlide() {
    if (_counter > 5) return false;
    _incrementCounter();
    return true;
  }

  @override
  bool onReverseSlide() {
    if (_counter == 0) return false;
    _decrementCounter();
    return true;
  }
}
