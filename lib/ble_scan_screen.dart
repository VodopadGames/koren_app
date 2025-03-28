import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEScanScreen extends StatefulWidget {
  const BLEScanScreen({super.key});

  @override
  _BLEScanScreenState createState() => _BLEScanScreenState();
}

class _BLEScanScreenState extends State<BLEScanScreen> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<ScanResult> scanResults = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    setState(() {
      scanResults.clear();
      isScanning = true;
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isScanning = false;
      });
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Connected to ${device.name}")),
    );
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
                      final device = scanResults[index].device;
                      return ListTile(
                        title: Text(device.name.isNotEmpty ? device.name : "Unknown Device"),
                        subtitle: Text(device.id.toString()),
                        trailing: ElevatedButton(
                          onPressed: () => connectToDevice(device),
                          child: const Text("Connect"),
                        ),
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
