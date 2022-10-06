import 'package:flutter/material.dart';

class ConditionalChecker extends StatelessWidget {
  final bool condition;
  final Widget trueItem;
  final Widget falseItem;
  const ConditionalChecker({
    Key? key,
    required this.condition,
    required this.trueItem,
    required this.falseItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? trueItem : falseItem;
  }
}
