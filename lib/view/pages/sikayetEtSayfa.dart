import 'package:device_info/device_info.dart';
import 'package:event_app/model/kullanici.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class SikayetEtSayfa extends StatefulWidget {
  final String? aktifKullaniciId;
  SikayetEtSayfa({Key? key, this.aktifKullaniciId}) : super(key: key);

  @override
  _SikayetEtSayfaState createState() => _SikayetEtSayfaState();
}

class _SikayetEtSayfaState extends State<SikayetEtSayfa> {
  Kullanici? _profilSahibi;
  final _formAnahtari = GlobalKey<FormState>();
  String? girilenMetin;
  bool _yukleniyor = false;
  final sikayetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: Text(
            'Bize Yazın',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [_sayfaElemanlari, _yuklemeAnimasyonu()],
        ));
  }

  Widget _yuklemeAnimasyonu() {
    if (_yukleniyor) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center();
    }
  }

  Widget get _sayfaElemanlari => FutureBuilder(
        future: FirestoreServisi().kullaniciGetir(widget.aktifKullaniciId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _profilSahibi = snapshot.data as Kullanici;
          //print("bu bir deneme" + _profilSahibi.toString());
          return SingleChildScrollView(
            child: Form(
              key: _formAnahtari,
              child: Column(
                children: [
                  Center(child: _reportAnimation),
                  _neredeYanlisText,
                  boslukHeight(context, 0.012),
                  _altYaziText,
                  _sikayetTextField,
                  boslukHeight(context, 0.012),
                  _gonderBtn(_profilSahibi!)
                ],
              ),
            ),
          );
        },
      );

  Widget get _neredeYanlisText => Row(
        children: [
          boslukWidth(context, 0.05),
          Text(
            'Nerede yanlış yaptık?',
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800,
              fontSize: MediaQuery.of(context).size.height * 0.028,
              color: Color(0xff252745),
            ),
          )
        ],
      );

  Widget get _altYaziText => Row(
        children: [
          boslukWidth(context, 0.05),
          Expanded(
            child: Text(
              'Uygulamayı sizin için en güzel hale getirmeye çalıştık. Fakat bir sorununuz veya öneriniz varsa mutlaka yazın. Önerinizi / Şikayetinizi yetenekli yazılım ekibimiz dikkate alacak.',
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.022,
                color: Color(0xff252745),
              ),
            ),
          )
        ],
      );

  Widget get _reportAnimation => Lottie.asset('assets/lottie/reported.json',
      repeat: false, height: MediaQuery.of(context).size.height * 0.3);

  Widget get _sikayetTextField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: TextFormField(
          controller: sikayetController,
          autocorrect: true,
          maxLength: 300,
          maxLines: 6,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
            fontSize: MediaQuery.of(context).size.height * 0.02,
            color: Color(0xff252745),
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              color: Color(0xffEF2E5B),
            ),
          ),
          onSaved: (input) {
            girilenMetin = input;
          },
          validator: (input) {
            if (input!.isEmpty) {
              return 'Metin alanı boş bırakılamaz.';
            } else if (input.length > 300) {
              return 'Max 300 karakter olmalı.';
            }
            return null;
          },
        ),
      );

  Widget _gonderBtn(Kullanici kullanici) {
    return InkWell(
      onTap: () {
        _gonder(kullanici);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xffe84a6f),
                  Color(0xffff5746),
                ])),
        child: Center(
            child: Text(
          'Gönder',
          style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Theme.of(context).scaffoldBackgroundColor),
        )),
      ),
    );
  }

  void _gonder(Kullanici kullanici) async {
    var _formState = _formAnahtari.currentState;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (_formState!.validate()) {
      _formState.save();
      FocusScope.of(context).unfocus();
      setState(() {
        _yukleniyor = true;
      });
      try {
        FirestoreServisi().sikayetOlustur(
            sikayetEdeninAdiSoyadi: kullanici.adSoyad,
            sikayetEdeninMaili: kullanici.email,
            sikayetMetni: sikayetController.text,
            sikayetEdeninTelefonu: androidInfo.model,
            sikayetEdenId: kullanici.id);
        setState(() {
          _yukleniyor = false;
        });
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            context: context,
            builder: (context) {
              return Column(
                children: [
                  Lottie.asset('assets/lottie/tick2.json',
                      repeat: false,
                      height: MediaQuery.of(context).size.height * 0.25),
                  _bottomSheetBasarili,
                  _bottomSheetAciklama,
                  boslukHeight(context, 0.04),
                  _tamamBtn,
                ],
              );
            });
      } catch (hata) {
        print("hata");
        print(hata.hashCode);
        print(hata);

        setState(() {
          _yukleniyor = false;
        });

        var snackBar = SnackBar(
            content:
                Text('Bir hata oluştu. Birkaç dakika içinde tekrar deneyin.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget get _bottomSheetBasarili => Text(
        'Teşekkürler',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w800,
          fontSize: MediaQuery.of(context).size.height * 0.04,
          color: Color(0xff252745),
        ),
      );

  Widget get _bottomSheetAciklama => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          'Görüşün bize ulaştı. Projemizi geliştirmede bize destek olduğun için çok teşekkür ederiz.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * 0.025,
            color: Color(0xff252745).withOpacity(0.7),
          ),
        ),
      );

  Widget get _tamamBtn => InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffFFC232), Color(0xffffb967)])),
          child: Center(
              child: Text(
            'Tamam',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Color(0xff252745)),
          )),
        ),
      );
}
