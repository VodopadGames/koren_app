import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final IconData icon;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0), // Симетрично разстояние
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: 360,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF2C4425),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Container(
                width: ((widget.value - widget.min) / (widget.max - widget.min)) * 230 + 50,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFC1A24C),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Positioned(
                left: 5,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 214, 233, 203),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF2C4425), width: 3),
                  ),
                  child: Icon(widget.icon, color: Color(0xFF2C4425), size: 25),
                ),
              ),
              Positioned(
                left: ((widget.value - widget.min) / (widget.max - widget.min)) * 250 + 15,
                child: Text(
                  "${widget.value.toInt()}°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0,
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  thumbColor: Colors.transparent,
                  overlayColor: Colors.transparent,
                  trackShape: RectangularSliderTrackShape(),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                ),
                child: Slider(
                  min: widget.min,
                  max: widget.max,
                  value: widget.value,
                  onChanged: widget.onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
