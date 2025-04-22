import 'package:flutter/material.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plants"),
      ),
      body: const Center(
        child: Text(
          "Тук е страницата с растения.",
          style: TextStyle(color: Colors.white),
          ),
      ),
    );
  }
}
