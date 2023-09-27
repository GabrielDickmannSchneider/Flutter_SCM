import 'package:flutter/material.dart';
import 'package:scm/models/resp_model.dart';

// ignore: must_be_immutable
class RespWidget extends InheritedWidget {
  RespModel currentResp = RespModel(email: "", senha: "");

  RespWidget({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  RespModel get resp => currentResp;

  static RespWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}