import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hacktrud/pages/chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const fontScale = 1.2;
    var themeData = ThemeData(
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
      canvasColor: Colors.black,
    );

    return Theme(
      data: themeData,
      child: PlatformApp(
        title: 'Хакатон труда 2',
        initialRoute: ChatPage.path,
        routes: {
          ChatPage.path: (context) => ChatPage(),
        },
      ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
