import 'dart:async';
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
  StreamSubscription<DiscoveredDevice>? scanSubscription;
  StreamSubscription<ConnectionStateUpdate>? connectionSubscription;

  @override
  void initState() {
    super.initState();
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

    scanSubscription?.cancel();
    scanSubscription = flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      setState(() {
        if (!scanResults.any((d) => d.id == device.id)) {
          scanResults.add(device);
        }
      });
    });

    Timer(const Duration(seconds: 13), () {
      scanSubscription?.cancel();
      setState(() {
        isScanning = false;
      });
    });
  }

  void connectToDevice(DiscoveredDevice device) {
    connectionSubscription?.cancel();
    connectionSubscription = flutterReactiveBle
        .connectToDevice(id: device.id, connectionTimeout: const Duration(seconds: 10))
        .listen((connectionState) {
      print('Connection state for ${device.name}: ${connectionState.connectionState}');
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        // Успешна връзка
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Connected'),
            content: Text('Connected to ${device.name}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (connectionState.connectionState == DeviceConnectionState.disconnected) {
        // Разкачена връзка
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Disconnected'),
            content: Text('Disconnected from ${device.name}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }, onError: (dynamic error) {
      print('Error connecting to ${device.name}: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Connection Error'),
          content: Text('Failed to connect to ${device.name}: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const appBarColor = Color(0xFFB7A34A);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan for BLE Devices"),
        backgroundColor: appBarColor,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: scanResults.isEmpty
                  ? const Center(
                      child: Text(
                        "No devices found",
                        style: TextStyle(color: Color(0xFFE0DAC4)),
                      ),
                    )
                  : ListView.builder(
                      itemCount: scanResults.length,
                      itemBuilder: (context, index) {
                        final device = scanResults[index];
                        return GestureDetector(
                          onTap: () => connectToDevice(device),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E4B2B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  device.name.isNotEmpty ? device.name : "Unknown Device",
                                  style: const TextStyle(
                                    color: Color(0xFFE0DAC4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  device.id,
                                  style: const TextStyle(color: Color(0xFFB7A34A)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBarColor,
                  foregroundColor: Colors.black,
                ),
                onPressed: startScan,
                child: Text(isScanning ? "Scanning..." : "Scan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}