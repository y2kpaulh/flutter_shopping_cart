import 'package:flutter/material.dart';

class OrderNumberPicker extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int stepValue;
  final Color backgroundColor;
  final Color themeColor;
  final void Function(int value)? onChanged;

  const OrderNumberPicker({
    super.key,
    this.initialValue = 1,
    this.minValue = 1,
    required this.maxValue,
    this.stepValue = 1,
    this.backgroundColor = Colors.white,
    this.themeColor = Colors.black,
    this.onChanged,
  });

  @override
  State<OrderNumberPicker> createState() => _OrderNumberPickerState();
}

class _OrderNumberPickerState extends State<OrderNumberPicker> {
  late Color _themeColor;
  late Color _backgroundColor;
  late int _maxValue;

  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _themeColor = widget.themeColor;
    _backgroundColor = widget.backgroundColor;
    _maxValue = widget.maxValue;
    _currentValue = widget.initialValue;
  }

  void _decrementValue() {
    final newValue = _currentValue - widget.stepValue;
    _updateValue(newValue.clamp(widget.minValue, _maxValue));
  }

  void _incrementValue() {
    final newValue = _currentValue + widget.stepValue;
    _updateValue(newValue.clamp(widget.minValue, _maxValue));
  }

  void _updateValue(int newValue) {
    setState(() {
      _currentValue = newValue;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(
          width: 1,
          color: _themeColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            color: _themeColor,
            icon: const Icon(Icons.remove),
            iconSize: 18,
            onPressed: _decrementValue,
          ),
          Text('$_currentValue', style: TextStyle(color: _themeColor, fontSize: 18, fontWeight: FontWeight.bold),),
          IconButton(
            color: _themeColor,
            icon: const Icon(Icons.add),
            iconSize: 18,
            onPressed: _incrementValue,
          ),
        ],
      ),
    );
  }
}
