import 'package:event_app/model/kullanici.dart';
import 'package:event_app/servisler/yetkilendirmeServisi.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:event_app/view/viewModel/tabbar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Yonlendirme extends StatelessWidget {
  const Yonlendirme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    return StreamBuilder(
      stream: _yetkilendirmeServisi.durumTakipcisi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          Kullanici? aktifKullanici = snapshot.data as Kullanici?;
          _yetkilendirmeServisi.aktifKullaniciId = aktifKullanici!.id;

          return TabBarMain();
        } else {
          return GirisSayfa();
        }
      },
    );
  }
}
