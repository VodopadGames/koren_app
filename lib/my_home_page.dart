import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'custom_slider.dart';
import 'plants.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.connectedDevice});

  final String title;
  final DiscoveredDevice connectedDevice;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterReactiveBle = FlutterReactiveBle();
  double temperature = 23;
  double humidity = 50;
  double light = 80;

  @override
  void initState() {
    super.initState();
    _subscribeToBLEData();
  }

  Future<void> debugServices(String deviceId) async {
    try {
      await flutterReactiveBle.discoverAllServices(deviceId); // Не е задължително, но може да помогне
      
      final List<Service> services = await flutterReactiveBle.getDiscoveredServices(deviceId);
      final List<DiscoveredService> discoveredServices = services.cast<DiscoveredService>().toList();
      
      for (final service in discoveredServices) {
        print("Service UUID: ${service.serviceId}"); // DiscoveredService -> serviceId
        for (final char in service.characteristics) {
          print("  -> Characteristic UUID: ${char.characteristicId} (Service: ${service.serviceId})"); // DiscoveredCharacteristic -> characteristicId
        }
      }
    } catch (e) {
      print("⚠️ Error discovering services: $e");
    }
  }

  void _subscribeToBLEData() async {
    await debugServices(widget.connectedDevice.id);
    print("Starting subscription after service discovery...");
    // Temperature
    flutterReactiveBle.subscribeToCharacteristic(QualifiedCharacteristic(
      serviceId: Uuid.parse("12345678-1234-5678-1234-56789abcdef0"), // New Service UUID
      characteristicId: Uuid.parse("abcdef01-1234-5678-1234-56789abcdef0"), // Temperature UUID
      deviceId: widget.connectedDevice.id,
    )).listen((data) {
      String receivedData = String.fromCharCodes(data);
      double temperature = double.tryParse(receivedData) ?? 23.0;
      setState(() {
        this.temperature = temperature;
      });
    });

    // Soil Moisture
    flutterReactiveBle.subscribeToCharacteristic(QualifiedCharacteristic(
      serviceId: Uuid.parse("12345678-1234-5678-1234-56789abcdef0"), // Same Service UUID
      characteristicId: Uuid.parse("bcdef103-2345-6789-2345-67890bcdef12"), // Soil Moisture UUID
      deviceId: widget.connectedDevice.id,
    )).listen((data) {
      String receivedData = String.fromCharCodes(data);
      double humidity = double.tryParse(receivedData) ?? 50.0;
      setState(() {
        this.humidity = humidity;
      });
    });
  }

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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlantsPage()),
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = MediaQuery.of(context).size.width;
                double iconBoxSize = screenWidth * 0.40;
                double iconSize = screenWidth * 0.38;
                double fontSize = screenWidth * 0.09; // 6% от ширината
                double arrowSize = screenWidth * 0.19; // 10% от ширината
                double squareSize = screenWidth * 0.9; // например 60% от ширината

                return Container(
                  width: squareSize,
                  height: squareSize,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF44633F),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: squareSize * 0.15,   // например 10% от височината
                      horizontal: squareSize * 0.05, // 5% от ширината
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_left, color: Colors.white, size: arrowSize),
                            Container(
                              width: iconBoxSize,
                              height: iconBoxSize,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC2A73E),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: Icon(Icons.eco, color: const Color(0xFF44633F), size: iconSize),
                              ),
                            ),
                            Icon(Icons.arrow_right, color: const Color.fromARGB(255, 255, 255, 255), size: arrowSize),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Мента",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

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
