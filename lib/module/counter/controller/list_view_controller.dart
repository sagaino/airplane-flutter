import 'package:airplane/module/counter/view/list_view.dart';
import 'package:flutter/material.dart';
  
class CheckChockController extends State<CheckChockView> {
  static late CheckChockController instance;
  late CheckChockView view;
  
  @override
  void initState() {
    instance = this;
    super.initState();
  }
  
  @override
  void dispose() => super.dispose();
  @override
  Widget build(BuildContext context) => widget.build(context, this);
  
}