import 'package:eevent/servisler/notificationServisi.dart';
import 'package:eevent/servisler/yetkilendirmeServisi.dart';
import 'package:eevent/internetUyari.dart';
import 'package:eevent/view/auth/girisSayfa.dart';
import 'package:eevent/view/auth/onBoardingSayfa.dart';
import 'package:eevent/view/pages/etkinlikDetaySayfa.dart';
import 'package:eevent/view/pages/anaSayfa.dart';
import 'package:eevent/view/pages/aramaSayfa.dart';
import 'package:eevent/view/theme/theme_light.dart';
import 'package:eevent/yonlendirme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

int? initScreen; //onboarding için

Future<void> main() async {
  timeago.setLocaleMessages('tr', timeago.TrMessages());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen $initScreen');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<YetkilendirmeServisi>(
      create: (_) => YetkilendirmeServisi(),
      child: MaterialApp(
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
        title: 'eevent',
        initialRoute:
            initScreen == 0 || initScreen == null ? "/" : "/yonlendirme",
        routes: {
          '/': (context) => OnBoardingSayfa(),
          '/uyari': (context) => InternetUyariSayfa(),
          '/yonlendirme': (context) => Yonlendirme(),
          '/girisSayfa': (context) => GirisSayfa(),
          '/homeSayfa': (context) => AnaSayfa(),
          '/searchSayfa': (context) => AramaSayfa(),
          '/etkinlikDetaySayfa': (context) => EtkinlikDetaySayfa(),
        },
      ),
    );
  }
}
