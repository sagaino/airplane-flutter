import 'package:airplane/module/counter/controller/list_view_controller.dart';
import 'package:flutter/material.dart';
  
class CheckChockView extends StatefulWidget {
  const CheckChockView({Key? key}) : super(key: key);
  
  @override
  State<CheckChockView> createState() => CheckChockController();
  Widget build(context, CheckChockController controller) {
    controller.view = this;
    return Scaffold(
      
    );
  }
}