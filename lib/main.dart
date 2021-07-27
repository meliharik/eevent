import 'package:event_app/servisler/yetkilendirmeServisi.dart';
import 'package:event_app/internetUyari.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:event_app/view/auth/onBoardingSayfa.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:event_app/view/pages/anaSayfa.dart';
import 'package:event_app/view/pages/aramaSayfa.dart';
import 'package:event_app/view/theme/theme_light.dart';
import 'package:event_app/yonlendirme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen $initScreen');

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

  // Future<String?> sayfaYonlendirme() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());

  //   if (connectivityResult != ConnectionState.none ||
  //       connectivityResult != ConnectionState.waiting) {
  //     if (initScreen == 0 || initScreen == null) {
  //       return "/";
  //     } else {
  //       return "/yonlendirme";
  //     }
  //   } else {
  //     return "/uyari";
  //   }
  // }
}
