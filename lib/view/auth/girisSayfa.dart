import 'package:connectivity/connectivity.dart';
import 'package:event_app/model/kullanici.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/servisler/yetkilendirmeServisi.dart';
import 'package:event_app/view/viewModel/tabbar_view.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:event_app/view/auth/kayitSayfa.dart';
import 'package:event_app/view/auth/sifremiUnuttumSayfa.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GirisSayfa extends StatefulWidget {
  const GirisSayfa({Key? key}) : super(key: key);

  @override
  _GirisSayfaState createState() => _GirisSayfaState();
}

class _GirisSayfaState extends State<GirisSayfa> {
  bool isObscureTextTrue = true;
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool _yukleniyor = false;
  String? email, sifre;

  @override
  void initState() {
    super.initState();
    internetKontrol();
  }

  @override
  void dispose() {
    _yukleniyor = false;
    internetKontrol();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldAnahtari,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _sayfaElemanlari(),
            _yuklemeAnimasyonu(),
          ],
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

  Widget _sayfaElemanlari() {
    return Form(
      key: _formAnahtari,
      child: Column(
        children: [
          boslukHeight(context, 0.05),
          _welcomeText,
          _devamEtText,
          boslukHeight(context, 0.08),
          _emailTextField,
          boslukHeight(context, 0.03),
          _sifreTextField,
          _sifremiUnuttumBtn,
          boslukHeight(context, 0.03),
          _girisYapBtn,
          boslukHeight(context, 0.03),
          _googleGirisBtn,
          _expandedHeight,
          _hesapOlusturNavigator,
          boslukHeight(context, 0.05),
        ],
      ),
    );
  }

  Widget get _welcomeText => Row(children: [
        boslukWidth(context, 0.04),
        SafeArea(
          child: Text(
            'Hoş Geldin,',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800,
              fontSize: MediaQuery.of(context).size.height * 0.04,
              color: Color(0xff252745),
            ),
          ),
        )
      ]);

  Widget get _devamEtText => Row(
        children: [
          boslukWidth(context, 0.04),
          Text(
            'Devam etmek için giriş yap!',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * 0.03,
              color: Color(0xff252745).withOpacity(0.7),
            ),
          )
        ],
      );

  Widget get _emailTextField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            color: Color(0xff252745),
          ),
          autocorrect: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(),
            hintText: 'Email',
            hintStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              color: Color(0xff252745),
            ),
            errorStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              color: Color(0xffEF2E5B),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffEF2E5B), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
          validator: (input) {
            if (input!.isEmpty) {
              return 'Email alanı boş bırakılamaz!';
            } else if (!input.contains('@')) {
              return 'Girilen değer mail formatında olmalı';
            }
            return null;
          },
          onSaved: (girilenDeger) {
            email = girilenDeger;
          },
        ),
      );

  Widget get _sifreTextField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            color: Color(0xff252745),
          ),
          obscureText: isObscureTextTrue,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: isObscureTextTrue
                    ? Icon(FontAwesomeIcons.eye)
                    : Icon(FontAwesomeIcons.eyeSlash),
                onPressed: () {
                  setState(() {
                    isObscureTextTrue = !isObscureTextTrue;
                  });
                },
              ),
            ),
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(),
            hintText: 'Şifre',
            hintStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              color: Color(0xff252745),
            ),
            errorStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              color: Color(0xffEF2E5B),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffEF2E5B), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
          validator: (input) {
            if (input!.isEmpty) {
              return 'Şifre alanı boş bırakılamaz!';
            } else if (input.trim().length <= 4) {
              return 'Şifre 4 karakterden az olamaz';
            }
            return null;
          },
          onSaved: (girilenDeger) {
            sifre = girilenDeger;
          },
        ),
      );

  Widget get _sifremiUnuttumBtn => Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Text(''),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SifremiUnuttumSayfa()));
            },
            child: Text(
              'Şifremi Unuttum',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Color(0xff252745),
              ),
            ),
          ),
          boslukWidth(context, 0.04)
        ],
      );

  Widget get _expandedHeight => Expanded(
          child: SizedBox(
        child: Text(''),
      ));

  Widget get _girisYapBtn => InkWell(
        onTap: _girisYap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Theme.of(context).primaryColor, Color(0xff6aa9c2)])),
          child: Center(
              child: Text(
            'Giriş Yap',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );

  void _girisYap() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    var connectivityResult = await (Connectivity().checkConnectivity());

    var _formState = _formAnahtari.currentState;
    if (_formState!.validate()) {
      _formState.save();
      FocusScope.of(context).unfocus();
      setState(() {
        _yukleniyor = true;
      });

      if (connectivityResult != ConnectivityResult.none) {
        try {
          Kullanici? kullanici =
              await _yetkilendirmeServisi.mailIleGiris(email!, sifre!);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TabBarMain(
                        aktifKullaniciId: kullanici!.id,
                      )));
        } catch (hata) {
          print("hata");
          print(hata.hashCode);
          print(hata);
          setState(() {
            _yukleniyor = false;
          });
          uyariGoster(hataKodu: hata.hashCode);
        }
      } else {
        setState(() {
          _yukleniyor = false;
        });
        uyariGoster(hataKodu: 0);
      }
    }
  }

  void _googleIleGiris() async {
    var _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    var connectivityResult = await (Connectivity().checkConnectivity());

    setState(() {
      _yukleniyor = true;
    });
    print("connection: " + connectivityResult.toString());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        Kullanici? kullanici = await _yetkilendirmeServisi.googleIleGiris();
        if (kullanici != null) {
          Kullanici? firestoreKullanici =
              await FirestoreServisi().kullaniciGetir(kullanici.id);
          if (firestoreKullanici == null) {
            FirestoreServisi().kullaniciOlustur(
                id: kullanici.id,
                email: kullanici.email,
                adSoyad: kullanici.adSoyad,
                fotoUrl: kullanici.fotoUrl);
          }
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TabBarMain(
                      aktifKullaniciId: kullanici!.id,
                    )));
      } catch (hata) {
        print("hata");
        print(hata.hashCode);
        print(hata);
        if (mounted) {
          setState(() {
            _yukleniyor = false;
          });
        }
        uyariGoster(hataKodu: hata.hashCode);
      }
    } else {
      setState(() {
        _yukleniyor = false;
      });
      uyariGoster(hataKodu: 0);
    }
  }

  internetKontrol() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      uyariGoster(hataKodu: 0);
    }
  }

  uyariGoster({hataKodu}) {
    String? hataMesaji;

    if (hataKodu == 505284406) {
      hataMesaji = "Böyle bir kullanıcı bulunmuyor.";
    } else if (hataKodu == 360587416) {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir.";
    } else if (hataKodu == 185768934) {
      hataMesaji = "Girilen şifre hatalı.";
    } else if (hataKodu == 446151799) {
      hataMesaji = "Kullanıcı engellenmiş.";
    } else if (hataKodu == 0) {
      hataMesaji = "İnternet bağlantınızı kontrol edin.";
    } else {
      hataMesaji = "Bir hata oluştu. Birkaç dakika içinde tekrar deneyin.";
    }

    // 474761051 The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff.

    var snackBar = SnackBar(content: Text('$hataMesaji'));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget get _googleGirisBtn => InkWell(
        onTap: _googleIleGiris,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffebeef4)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/google.png',
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Google ile Giriş Yap',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Color(0xff252745)),
                ),
              )
            ])),
      );

  Widget get _hesapOlusturNavigator => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Buralarda yeni misin?',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Color(0xff252745),
            ),
          )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KayitSayfa()));
              },
              child: Text(
                ' Hesap oluştur',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800,
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  color: Color(0xff6759c2),
                ),
              ))
        ],
      );
}
