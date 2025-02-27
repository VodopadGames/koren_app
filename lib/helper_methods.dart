import 'package:flutter/material.dart';

Widget buildSlider(String label, double value, double min, double max, IconData icon, Function(double) onChanged) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.amber, size: 30),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
              SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                  trackHeight: 6,
                  activeTrackColor: Colors.amber,
                  inactiveTrackColor: Colors.grey,
                  thumbColor: Colors.amber,
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: 10,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        Text('${value.toInt()}%', style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    ),
  );
}
