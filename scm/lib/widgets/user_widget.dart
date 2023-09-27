import "package:flutter/material.dart";
import "package:scm/models/user_model.dart";

// ignore: must_be_immutable
class UserWidget extends InheritedWidget {
  UserModel currentUser = UserModel(email: "", senha: "");

  UserWidget({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  UserModel get user => currentUser;

  static UserWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}