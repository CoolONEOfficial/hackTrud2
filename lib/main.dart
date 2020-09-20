import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hacktrud/pages/chat.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const fontScale = 1.2;
    var themeData = ThemeData(
      iconTheme: IconThemeData(
        size: 24,
        color: Colors.white,
      ),
      fontFamily: "ProximaNova",
      brightness: Brightness.dark,
      accentTextTheme: Theme.of(context).accentTextTheme.apply(
            fontFamily: "ProximaNovaBold",
            fontSizeFactor: fontScale,
          ),
      textTheme: Theme.of(context).accentTextTheme.apply(
            fontFamily: "ProximaNova",
            fontSizeFactor: fontScale,
          ),
      backgroundColor: kIsWeb ? Colors.transparent : null,
      canvasColor: kIsWeb ? Colors.transparent : null,
      accentColor: Colors.grey,
    );

    return Theme(
      data: themeData,
      child: PlatformApp(
        title: 'Хакатон труда 2',
        builder: (context, widget) => ResponsiveWrapper.builder(
          ChatPage(),
          maxWidth: 600,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(600, name: TABLET),
            ResponsiveBreakpoint.resize(600, name: DESKTOP),
          ],
          background: kIsWeb
              ? CustomPaint(
                  size: Size.infinite,
                  painter: WebBackgroundPainter(),
                )
              : null,
        ),
      ),
    );
  }
}

class WebBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ThemeData.dark().canvasColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();
    // Draws a line from left top corner to right bottom
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 12 * 10);
    path.lineTo(0, size.height / 12 * 11);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WebBackgroundPainter oldDelegate) => true;
}
