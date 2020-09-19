import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/message.dart';

class MyMessage extends StatelessWidget {
  final Widget child;

  const MyMessage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Message(
        padding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 22,
        ),
        color: Colors.white,
        child: child,
      );
}
