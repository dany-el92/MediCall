import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
}

