import 'package:flutter/material.dart';
import 'package:myapp/pages/weather_page.dart';
import 'package:myapp/pages/earthquake_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwipePages(),
    );
  }
}

class SwipePages extends StatefulWidget {
  const SwipePages({Key? key}) : super(key: key);

  @override
  _SwipePagesState createState() => _SwipePagesState();
}

class _SwipePagesState extends State<SwipePages> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          const WeatherPage(),
          EarthquakePage(),
        ],
      ),
    );
  }
}