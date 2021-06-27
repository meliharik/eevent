import 'dart:math';
import 'package:event_app/model/widthAndHeight.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({Key? key}) : super(key: key);

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int generateRandomNumber() {
    var _random = Random();
    return _random.nextInt(100); // 0 - 99
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            boslukHeight(context, 0.03),
            _fotoVeIsim(context),
            boslukHeight(context, 0.03),
            _customDivider,
            _emailListTile(),
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
    );
  }

  Widget _fotoVeIsim(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        boslukWidth(context, 0.04),
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/${generateRandomNumber()}.jpg'),
          radius: MediaQuery.of(context).size.height * 0.06,
        ),
        boslukWidth(context, 0.04),
        Flexible(
          child: Text(
            'Melih Arık',
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

  Widget _emailListTile() {
    return ListTile(
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      leading: Icon(
        FontAwesomeIcons.solidEnvelope,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        'deneme_mail@deneme.com.tr',
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
      onTap: () {
        //TODO: çıkış yapacak
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GirisSayfa()));
        print("çıkış yapacak ");
      },
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
