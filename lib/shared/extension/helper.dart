import 'package:flutter/material.dart';

class Helper{
  Helper._();

    static void afterInit(Function function) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      function();
    });
  }
}