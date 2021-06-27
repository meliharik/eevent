import 'package:event_app/model/tabbar_view.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:event_app/view/pages/anaSayfa.dart';
import 'package:event_app/view/pages/aramaSayfa.dart';
import 'package:event_app/view/theme/theme_light.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFdfadfa))),
      theme: myThemeLight,
      debugShowCheckedModeBanner: false,
      title: 'eventa',
      initialRoute: '/',
      routes: {
        '/': (context) => GirisSayfa(),
        '/homeScreen': (context) => AnaSayfa(),
        '/searchScreen': (context) => AramaSayfa(),
        '/etkinlikDetay': (context) => EtkinlikDetaySayfa(),
      },
    );
  }
}
