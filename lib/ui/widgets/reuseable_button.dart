import 'package:flutter/material.dart';

class ReuseButton extends StatefulWidget {
  final Function() onPressed;
  final String? label;

  const ReuseButton({
    Key? key,
    required this.onPressed,
    this.label,
  }) : super(key: key);

  @override
  State<ReuseButton> createState() => _ReuseButtonState();
}

class _ReuseButtonState extends State<ReuseButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,
      ),
      onPressed: widget.onPressed,
      child: Text("${widget.label}"),
    );
  }
}
