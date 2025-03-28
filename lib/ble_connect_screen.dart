import 'package:flutter/material.dart';
import 'ble_scan_screen.dart'; // Import the scan screen

class BLEConnectScreen extends StatelessWidget {
  const BLEConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFC2A73E),
        elevation: 0,
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
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Center(
            child: Text(
              "Изглежда нямаш устройства. Добави ново от иконата долу вляво.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.arrow_downward,
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFFC2A73E),
                onPressed: () {
                  // Navigate to BLE scanning screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BLEScanScreen()),
                  );
                },
                child: const Icon(Icons.add, color: Colors.black, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
