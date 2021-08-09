import 'package:event_app/model/kullanici.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/servisler/notificationServisi.dart';
import 'package:event_app/servisler/yetkilendirmeServisi.dart';
import 'package:event_app/view/auth/sifremiDegistir.dart';
import 'package:event_app/view/pages/profiliDuzenleSayfa.dart';
import 'package:event_app/view/pages/sikayetEtSayfa.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilSayfa extends StatefulWidget {
  final String? profilSahibiId;
  const ProfilSayfa({Key? key, this.profilSahibiId}) : super(key: key);

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {
  Kullanici? _profilSahibi;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser!.reload();
    if (user!.emailVerified) {
      FirestoreServisi().dogrulamaGuncelle(
          kullaniciId: widget.profilSahibiId, dogrulandiMi: "true");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Profil',
          style: TextStyle(
              color: Color(0xff252745),
              fontSize: MediaQuery.of(context).size.height * 0.027,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800),
        ),
      ),
      body: FutureBuilder(
        future: FirestoreServisi().kullaniciGetir(widget.profilSahibiId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _profilSahibi = snapshot.data as Kullanici;
          //print("bu bir deneme" + _profilSahibi.toString());
          return SingleChildScrollView(
            child: Column(
              children: [
                boslukHeight(context, 0.03),
                _fotoVeIsim(context, _profilSahibi!),
                boslukHeight(context, 0.03),
                _customDivider,
                _emailListTile(_profilSahibi),
                _customDivider,
                _profiliDuzenleListTile(_profilSahibi!),
                _customDivider,
                _sifremiDegistirListTile(_profilSahibi!),
                _customDivider,
                //_yardimListTile,
                //_customDivider,
                _sikayetListTile,
                _customDivider,
                _puanlaListTile,
                _customDivider,
                _cikisYap(),
                boslukHeight(context, 0.1),
                _versiyonColumn,
                boslukHeight(context, 0.1),
              ],
            ),
          );
        },
      ),
    );
  }

  // body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           boslukHeight(context, 0.03),
  //           FutureBuilder(
  //             future: FirestoreServisi().kullaniciGetir(widget.profilSahibiId),
  //             builder: (context, snapshot) {
  //               if (!snapshot.hasData) {
  //                 return Row(
  //                   children: [
  //                     boslukWidth(context, 0.1),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: CircularProgressIndicator(),
  //                     )
  //                   ],
  //                 );
  //               }
  //               _profilSahibi = snapshot.data as Kullanici;
  //               print("bu bir deneme" + _profilSahibi.toString());
  //               return _fotoVeIsim(context, snapshot.data as Kullanici);
  //             },
  //           ),
  //           boslukHeight(context, 0.03),
  //           _customDivider,
  //           FutureBuilder(
  //             future: FirestoreServisi().kullaniciGetir(widget.profilSahibiId),
  //             builder: (context, snapshot) {
  //               if (!snapshot.hasData) {
  //                 return Row(
  //                   children: [
  //                     boslukWidth(context, 0.1),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: CircularProgressIndicator(),
  //                     )
  //                   ],
  //                 );
  //               }
  //               return _emailListTile(snapshot.data as Kullanici);
  //             },
  //           ),
  //           _customDivider,
  //           _profiliDuzenleListTile(_profilSahibi),
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
  //     ),

  Widget _fotoVeIsim(BuildContext context, Kullanici profilData) {
    return Row(
      children: [
        boslukWidth(context, 0.04),
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: profilData.fotoUrl!.isNotEmpty
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
    User? user = FirebaseAuth.instance.currentUser;

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
          onPressed: () async {
            if (!user!.emailVerified) {
              await user.sendEmailVerification();
              var snackBar = SnackBar(
                  content: Text('Mail adresinize doğrulama linki gönderdik.'));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              FirestoreServisi().dogrulamaGuncelle(
                  kullaniciId: widget.profilSahibiId, dogrulandiMi: "true");
              var snackBar =
                  SnackBar(content: Text('Mailiniz çoktan doğrulandı.'));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
          child: Text(
            user!.emailVerified == true ? 'Doğrulandı' : 'Doğrula',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                // fontSize: 20,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          )),
    );
  }

  // _dogrulamaMailGonder() async {
  //   if (_dogrulandi == true) {
  //     var snackBar =
  //         SnackBar(content: Text('Mail adresinizi zaten doğruladınız.'));
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   } else {
  //     await Provider.of<YetkilendirmeServisi>(context, listen: false)
  //         .mailiOnayla();
  //     var snackBar = SnackBar(
  //         content: Text('Doğrulama linki mail adresinize gönderildi.'));
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   }
  // }

  Widget _profiliDuzenleListTile(Kullanici profilData) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfiliDuzenleSayfa(
                      profilSahibiId: profilData,
                    )));
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

  Widget _sifremiDegistirListTile(Kullanici profilData) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SifremiDegistirSayfa(
                      profilSahibiId: profilData,
                    )));
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SikayetEtSayfa(
                        aktifKullaniciId: widget.profilSahibiId,
                      )));
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

  Widget get _puanlaListTile => InkWell(
        onTap: () {
          launch(
              "https://play.google.com/store/apps/details?id=app.eevent.eevent");
        },
        child: ListTile(
          minVerticalPadding: 0,
          horizontalTitleGap: 0,
          leading: Icon(
            FontAwesomeIcons.solidStar,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Puanla',
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
      await NotificationService().cancelAllNotifications();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GirisSayfa()));
    } catch (hata) {
      print("hata");
      print(hata.hashCode);
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
          'Versiyon 1.0.0',
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
