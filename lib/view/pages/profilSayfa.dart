import 'dart:math';
import 'package:event_app/model/kullanici.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/servisler/yetkilendirmeServisi.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({Key? key}) : super(key: key);

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    String? aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Profil',
          style: TextStyle(
              color: Color(0xff252745),
              fontSize: 20,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            boslukHeight(context, 0.03),
            FutureBuilder(
              future: FirestoreServisi().kullaniciGetir(aktifKullaniciId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Row(
                    children: [
                      boslukWidth(context, 0.1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    ],
                  );
                }
                return _fotoVeIsim(context, snapshot.data as Kullanici);
              },
            ),
            boslukHeight(context, 0.03),
            _customDivider,
            FutureBuilder(
              future: FirestoreServisi().kullaniciGetir(aktifKullaniciId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Row(
                    children: [
                      boslukWidth(context, 0.1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    ],
                  );
                }
                return _emailListTile(snapshot.data as Kullanici);
              },
            ),
            _customDivider,
            _profiliDuzenleListTile(),
            _customDivider,
            _sifremiDegistirListTile(),
            _customDivider,
            _yardimListTile,
            _customDivider,
            _sikayetListTile,
            _customDivider,
            _cikisYap(),
            boslukHeight(context, 0.1),
            _versiyonColumn,
          ],
        ),
      ),
      // body: FutureBuilder(
      //   future: FirestoreServisi().kullaniciGetir(aktifKullaniciId),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Scaffold(
      //           body: Center(
      //         child: CircularProgressIndicator(),
      //       ));
      //     }
      //     return SingleChildScrollView(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           boslukHeight(context, 0.03),
      //           _fotoVeIsim(context, snapshot.data as Kullanici?),
      //           boslukHeight(context, 0.03),
      //           _customDivider,
      //           _emailListTile(snapshot.data as Kullanici?),
      //           _customDivider,
      //           _profiliDuzenleListTile(),
      //           _customDivider,
      //           _sifremiDegistirListTile(),
      //           _customDivider,
      //           _yardimListTile,
      //           _customDivider,
      //           _sikayetListTile,
      //           _customDivider,
      //           _cikisYap(),
      //           boslukHeight(context, 0.1),
      //           _versiyonColumn,
      //         ],
      //       ),
      //     );
      //   },
      // )
    );
  }

  Widget _fotoVeIsim(BuildContext context, Kullanici? profilData) {
    return Row(
      children: [
        boslukWidth(context, 0.04),
        CircleAvatar(
          //child: ClipOval(child: Image.network(profilData!.fotoUrl.toString())),
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: profilData!.fotoUrl!.isNotEmpty
              ? NetworkImage(profilData.fotoUrl.toString())
              : AssetImage("assets/images/default_profile.png")
                  as ImageProvider,
          radius: MediaQuery.of(context).size.height * 0.06,
        ),
        boslukWidth(context, 0.04),
        Flexible(
          child: Text(
            profilData.adSoyad.toString(),
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.023,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
        ),
        boslukHeight(context, 0.02)
      ],
    );
  }

  // _fotoGetir(Kullanici? profilData) {
  //   if (profilData!.fotoUrl == "") {
  //     return AssetImage("assets/images/default_profile.png");
  //   } else {
  //     return NetworkImage(profilData.fotoUrl.toString());
  //   }
  // }

  // Center(
  //       child: Container(
  //         child: SvgPicture.network("https://avatars.dicebear.com/api/botts/" +
  //             profilData.email.toString() +
  //             ".svg?background%23fafafa"),
  //       ),
  //     );

  // "https://avatars.dicebear.com/api/bottts/" +
  //                             profilData.kullaniciAdi +
  //                             ".svg?background=%232f3136"

  Widget _emailListTile(Kullanici? profilData) {
    return ListTile(
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      leading: Icon(
        FontAwesomeIcons.solidEnvelope,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        profilData!.email.toString(),
        style: TextStyle(
            color: Color(0xff252745),
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600),
      ),
      trailing: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).primaryColor)),
          onPressed: () {
            //TODO: maili onaylanacak snackbar gösterilecek kod gönderilecek
            print('Maili onayla sayfası');
          },
          child: Text(
            'Doğrula',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                // fontSize: 20,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          )),
    );
  }

  Widget _profiliDuzenleListTile() {
    return InkWell(
      onTap: () {
        //TODO: Profili düzenle sayfasına gidecek
        print("Profili Düzenle Sayfasına gideek");
      },
      child: ListTile(
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        leading: Icon(
          FontAwesomeIcons.userAlt,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Profili Düzenle',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          FontAwesomeIcons.angleRight,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _sifremiDegistirListTile() {
    return InkWell(
      onTap: () {
        //TODO: Şifremi değiştir sayfasına gidecek
        print("Şifremi değiştir sayfasına gidecek");
      },
      child: ListTile(
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        leading: Icon(
          FontAwesomeIcons.lock,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Şifremi Değiştir',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          FontAwesomeIcons.angleRight,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget get _yardimListTile => ListTile(
        onTap: () {
          //TODO: yardım sayfasına gidecek
          print("Yardım sayfasına gidecek");
        },
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        leading: Icon(
          FontAwesomeIcons.question,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Yardım',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          FontAwesomeIcons.angleRight,
          color: Theme.of(context).primaryColor,
        ),
      );

  Widget get _sikayetListTile => InkWell(
        onTap: () {
          //TODO: şikayet et sayfasına gidecek
          print("şikayet sayfasına gidecek");
        },
        child: ListTile(
          minVerticalPadding: 0,
          horizontalTitleGap: 0,
          leading: Icon(
            FontAwesomeIcons.solidTimesCircle,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Şikayet',
            style: TextStyle(
                color: Color(0xff252745),
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600),
          ),
          trailing: Icon(
            FontAwesomeIcons.angleRight,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );

  Widget _cikisYap() {
    return InkWell(
      onTap: _cikisYapFonk,
      child: ListTile(
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        leading: Icon(
          FontAwesomeIcons.signOutAlt,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Çıkış Yap',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          FontAwesomeIcons.angleRight,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  void _cikisYapFonk() async {
    try {
      await Provider.of<YetkilendirmeServisi>(context, listen: false)
          .cikisYap();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GirisSayfa()));
    } catch (hata) {
      print(hata);
      var snackBar = SnackBar(content: Text('Bir hata oluştu: $hata'));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget get _versiyonColumn => Column(children: [
        Text(
          'eevent',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600),
        ),
        Text(
          'Versiyon 2.8.6',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400),
        ),
        Text(
          '\u00a9 2021 eevent LLC',
          style: TextStyle(
              color: Color(0xff252745),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400),
        )
      ]);

  Widget get _customDivider =>
      Divider(color: Theme.of(context).primaryColor.withOpacity(0.8));
}
