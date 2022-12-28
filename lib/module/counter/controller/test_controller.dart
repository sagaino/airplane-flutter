import 'package:airplane/module/counter/view/test.dart';
import 'package:flutter/material.dart';

class TestController extends State<TestView>{
  static late TestController instance;
  late TestView view;
  @override
  void initState() {
    instance = this;
    super.initState();
  }
  @override
  void dispose() => super.dispose();
  
  @override
  Widget build(BuildContext context) => widget.build(context, this);
  String name = "Sagaino";

}