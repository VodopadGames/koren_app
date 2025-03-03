import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'custom_slider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koren',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black, // Черен фон за целия екран
      ),
      
      debugShowCheckedModeBanner: true,
      home: const MyHomePage(title: 'Koren App Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double temperature = 23;
  double humidity = 50;
  double light = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust height if needed
        child: AppBar(
          backgroundColor: const Color(0xFFC2A73E), // Gold color
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16), // Curved edges
            ),
          ),
          leading: SizedBox(
            width: 56, // Ensures larger tap area
            height: 56,
            child: IconButton(
              iconSize: 32, // Bigger icon
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {},
            ),
          ),
          title: const Text(
            'KOREN',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Montserat",
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 56, // Ensures larger tap area
              height: 56,
              child: IconButton(
                iconSize: 32, // Bigger icon
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomSlider(
            value: temperature,
            min: 0,
            max: 50,
            iconPic: "assets/icons/thermostat.svg",
            showPercentage: false,
            onChanged: (value) {
              setState(() {
                temperature = value;
              });
            },
          ),
          SizedBox(height: 10,),
          CustomSlider(
            value: humidity,
            min: 0,
            max: 100,
            iconPic: "assets/icons/mist.svg",
            showPercentage: true,
            onChanged: (value) {
              setState(() {
                humidity = value;
              });
            },
          ),
          SizedBox(height: 10,),
          CustomSlider(
            value: light,
            min: 0,
            max: 100,
            iconPic: "assets/icons/light.svg",
            showPercentage: true,
            onChanged: (value) {
              setState(() {
                light = value;
              });
            },
          ),
          SizedBox(height: 20,),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
