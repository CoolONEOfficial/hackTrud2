import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Message extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;

  const Message({
    Key key,
    @required this.child,
    this.color = const Color.fromARGB(255, 98, 98, 98),
    this.padding = const EdgeInsets.symmetric(
      vertical: 13,
      horizontal: 22,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: padding,
      child: child,
    );
  }
}
