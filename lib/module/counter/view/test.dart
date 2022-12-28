import 'package:airplane/module/counter/controller/test_controller.dart';
import 'package:airplane/theme.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => TestController();
  Widget build(context, TestController controller) {
    controller.view = this;
    return Scaffold(
      body: Text(
        controller.name,
        style: greenTextStyle.copyWith(
          fontSize: 50,
          fontWeight: bold,
        ),
      ),
    );
  }
}
