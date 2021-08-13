import 'package:connectivity/connectivity.dart';
import 'package:eevent/internetUyari.dart';
import 'package:eevent/model/kullanici.dart';
import 'package:eevent/servisler/yetkilendirmeServisi.dart';
import 'package:eevent/view/auth/girisSayfa.dart';
import 'package:eevent/view/viewModel/tabbar_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class Yonlendirme extends StatefulWidget {
  @override
  _YonlendirmeState createState() => _YonlendirmeState();
}

class _YonlendirmeState extends State<Yonlendirme> {
  bool interneteBagliMi = true;
  @override
  void initState() {
    super.initState();
    internetKontrol();
  }

  @override
  Widget build(BuildContext context) {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    return StreamBuilder(
      stream: _yetkilendirmeServisi.durumTakipcisi,
      builder: (context, snapshot) {
        if (interneteBagliMi == false) {
          return InternetUyariSayfa();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
              child: LoadingBouncingGrid.square(
                duration: Duration(milliseconds: 750),
                size: MediaQuery.of(context).size.height * 0.05,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ));
          }
          if (snapshot.hasData) {
            Kullanici? aktifKullanici = snapshot.data as Kullanici?;
            _yetkilendirmeServisi.aktifKullaniciId = aktifKullanici!.id;

            return TabBarMain(
              aktifKullaniciId: aktifKullanici.id,
            );
          } else {
            return GirisSayfa();
          }
        }
      },
    );
  }

  Future internetKontrol() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      interneteBagliMi = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      interneteBagliMi = true;
    }
  }
}
