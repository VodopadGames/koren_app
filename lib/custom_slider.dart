import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final String iconPic;
  final bool showPercentage;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.iconPic,
    required this.showPercentage,
    required this.onChanged,
  });

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
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
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Container(
                width: ((widget.value - widget.min) / (widget.max - widget.min)) * 310 + 50,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFC1A24C),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFC1A24C),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF2C4425), width: 4),
                  ),
                  child: Center(
                    child: SizedBox( 
                      width: 40, 
                      height: 40, 
                      child: SvgPicture.asset(
                        widget.iconPic,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(Color(0xFF2C4425), BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: ((widget.value - widget.min) / (widget.max - widget.min)) * 250 + 15,
                child: Text(
                  widget.value >= 10 
                  ? "${widget.value.toInt()}${widget.showPercentage ? '%' : '°'}" 
                  : "",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 30,
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
