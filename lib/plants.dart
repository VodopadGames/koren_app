import 'package:flutter/material.dart';
import 'plant_details.dart'; // <-- Добавяме това

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  final List<String> plants = const ['Мента', 'Босилек', 'Розмарин', 'Чубрица'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        title: const Text("Избери растение"),
        backgroundColor: const Color(0xFFC2A73E),
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF44633F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC2A73E),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context, plant);
                      },
                      child: const Text("Избери"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF44633F),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlantDetailsPage(plantName: plant),
                          ),
                        );
                      },
                      child: const Text("Прегледай"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
