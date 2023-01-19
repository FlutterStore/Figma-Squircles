import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const niceGradient = LinearGradient(
  colors: [
    Color(0xFFFF4286),
    Color(0xFFFF6666),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Mode> selected = const <Mode>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Figma Squircle",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
        centerTitle: true,
      ),
      body: PageView(
        children: const [
          CompareExample(),
          EditorExample(),
          AnimatedExample(),
        ],
      ),
    );
  }
}

//CompareExample

class CompareExample extends StatelessWidget {
  const CompareExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: 200,
                height: 200,
                decoration: ShapeDecoration(
                  gradient: niceGradient,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 365,
                      cornerSmoothing: 1,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Smooth (365,1)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: 200,
                height: 200,
                decoration: ShapeDecoration(
                  gradient: niceGradient,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Continuous (50)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: niceGradient,
                  borderRadius: BorderRadius.circular(365),
                ),
                child: const Center(
                  child: Text(
                    'Circular',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//EditorExample 

class EditorExample extends StatefulWidget {
  const EditorExample({
    Key? key,
  }) : super(key: key);

  @override
  _EditorExampleState createState() => _EditorExampleState();
}

class _EditorExampleState extends State<EditorExample> {
  double cornerRadius = 0;
  double cornerSmoothing = 1.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.elasticOut,
                height: 200,
                width: 200,
                decoration: ShapeDecoration(
                  gradient: niceGradient,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: cornerRadius,
                      cornerSmoothing: cornerSmoothing,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
              'radius: ${cornerRadius.toStringAsFixed(1)}, smoothing: ${cornerSmoothing.toStringAsFixed(1)}'),
          Slider(
            min: 0,
            max: 300,
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.5),
            value: cornerRadius,
            onChanged: (v) => setState(() => cornerRadius = v),
          ),
          Slider(
            min: 0,
            max: 1,
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.5),
            value: cornerSmoothing,
            onChanged: (v) => setState(() => cornerSmoothing = v),
          ),
        ],
      ),
    );
  }
}



//AnimatedExample 


class AnimatedExample extends StatefulWidget {
  const AnimatedExample({
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedExampleState createState() => _AnimatedExampleState();
}

class _AnimatedExampleState extends State<AnimatedExample> {
  int radius = 0;
  List<SmoothBorderRadius> animateRadius = [
    SmoothBorderRadius(
      cornerRadius: 10,
      cornerSmoothing: 1,
    ),
    SmoothBorderRadius(
      cornerRadius: 25,
      cornerSmoothing: 1,
    ),
    SmoothBorderRadius(
      cornerRadius: 50,
      cornerSmoothing: 0.5,
    ),
    SmoothBorderRadius(
      cornerRadius: 75,
      cornerSmoothing: 0.5,
    ),
    SmoothBorderRadius(
      cornerRadius: 365,
      cornerSmoothing: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.elasticOut,
                height: 200,
                width: 200,
                decoration: ShapeDecoration(
                  gradient: niceGradient,
                  shape: SmoothRectangleBorder(
                    borderRadius: animateRadius[radius],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green),padding: MaterialStatePropertyAll(EdgeInsets.all(10))),
              onPressed: () {
                setState(() {
                  radius = (radius + 1) % animateRadius.length;
                });
              },
              child: Text('${animateRadius[radius]}'),
            ),
          )
        ],
      ),
    );
  }
}


enum Mode {
  rectangle,
  smooth,
  circular,
  continuous,
}