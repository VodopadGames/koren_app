import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEScanScreen extends StatefulWidget {
  const BLEScanScreen({super.key});

  @override
  _BLEScanScreenState createState() => _BLEScanScreenState();
}

class _BLEScanScreenState extends State<BLEScanScreen> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> scanResults = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  Future<void> requestBLEPermissions() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      print("Bluetooth permissions granted!");
    } else {
      print("Bluetooth permissions denied!");
    }
  }

  void startScan() async {
    await requestBLEPermissions();
    setState(() {
      scanResults.clear();
      isScanning = true;
    });

    flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      setState(() {
        if (!scanResults.any((d) => d.id == device.id)) {
          scanResults.add(device);
        }
      });
    }, onDone: () {
      setState(() {
        isScanning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan for BLE Devices"),
        backgroundColor: const Color(0xFFC2A73E),
      ),
      body: Column(
        children: [
          Expanded(
            child: scanResults.isEmpty
                ? const Center(child: Text("No devices found", style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    itemCount: scanResults.length,
                    itemBuilder: (context, index) {
                      final device = scanResults[index];
                      return ListTile(
                        title: Text(device.name.isNotEmpty ? device.name : "Unknown Device"),
                        subtitle: Text(device.id),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: isScanning ? null : startScan,
              child: Text(isScanning ? "Scanning..." : "Scan Again"),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
