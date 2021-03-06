import 'package:connectivity/connectivity.dart';
import 'package:eevent/model/kullanici.dart';
import 'package:eevent/servisler/firestoreServisi.dart';
import 'package:eevent/servisler/yetkilendirmeServisi.dart';
import 'package:eevent/view/sozlesmeler/gizlilikPolitikasi.dart';
import 'package:eevent/view/sozlesmeler/kullanimKosullari.dart';
import 'package:eevent/view/viewModel/tabbar_view.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:eevent/view/auth/girisSayfa.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  _KayitSayfaState createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  bool isObscureTextTrue = true;
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool _yukleniyor = false;
  String? adSoyad, email, sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldAnahtari,
        body: Stack(
          children: [
            _sayfaElemanlari(),
            _yuklemeAnimasyonu(),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    internetKontrol();
  }

  @override
  void dispose() {
    _yukleniyor = false;
    super.dispose();
  }

  Widget _yuklemeAnimasyonu() {
    if (_yukleniyor) {
      return Center(
        child: LoadingBouncingGrid.square(
          duration: Duration(milliseconds: 750),
          size: MediaQuery.of(context).size.height * 0.05,
          backgroundColor: Theme.of(context).primaryColor,
        ),
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
          _adSoyadTextField,
          boslukHeight(context, 0.03),
          _emailTextField,
          boslukHeight(context, 0.03),
          _sifreTextField,
          boslukHeight(context, 0.01),
          _bilgilendirmeText,
          boslukHeight(context, 0.03),
          _hesapOlusturBtn,
          boslukHeight(context, 0.03),
          _googleKayitBtn,
          _expandedHeight,
          _girisYapNavigator,
          boslukHeight(context, 0.05),
        ],
      ),
    );
  }

  Widget get _bilgilendirmeText => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Kaydolarak ',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400)),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GizlilikPolitikasiSayfa())),
                text: 'Gizlilik Politikas??',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600)),
            TextSpan(
                text: ' ve ',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400)),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KullanimKosullariSayfa())),
                text: 'Kullan??m Ko??ullar??n??',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600)),
            TextSpan(
                text: ' kabul etmi?? say??l??rs??n??z.',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400)),
          ]),
        ),
      );

  Widget get _welcomeText => Row(children: [
        boslukWidth(context, 0.04),
        SafeArea(
          child: Text(
            'Hesap Olu??tur,',
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
            'Kay??t ol ve aram??za kat??l!',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * 0.03,
              color: Color(0xff252745).withOpacity(0.7),
            ),
          )
        ],
      );

  Widget get _adSoyadTextField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            color: Color(0xff252745),
          ),
          autocorrect: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(),
            hintText: 'Ad Soyad',
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
              print(input.toString());
              return 'Ad Soyad alan?? bo?? b??rak??lamaz!';
            } else if (input.contains(',') ||
                input.contains('.') ||
                input.contains('*')) {
              print(input.toString());
              return 'L??tfen noktalama i??areti kullanmay??n.';
            }
            return null;
          },
          onSaved: (deger) {
            adSoyad = deger;
          },
        ),
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
              return 'Email alan?? bo?? b??rak??lamaz!';
            } else if (!input.contains('@')) {
              return 'Girilen de??er mail format??nda olmal??';
            }
            return null;
          },
          onSaved: (deger) {
            email = deger;
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
            hintText: '??ifre',
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
              return '??ifre alan?? bo?? b??rak??lamaz!';
            } else if (input.trim().length <= 4) {
              return '??ifre 4 karakterden az olamaz';
            }
            return null;
          },
          onSaved: (deger) {
            sifre = deger;
          },
        ),
      );

  Widget get _expandedHeight => Expanded(
          child: SizedBox(
        height: 0,
      ));

  Widget get _hesapOlusturBtn => InkWell(
        onTap: _hesapOlustur,
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
            'Hesap Olu??tur',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );

  Widget get _googleKayitBtn => InkWell(
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
                  'Google ile Hesap Olu??tur',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Color(0xff252745)),
                ),
              )
            ])),
      );

  Future<void> _hesapOlustur() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    var _formState = _formAnahtari.currentState;

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (_formState!.validate()) {
      _formState.save();
      FocusScope.of(context).unfocus();
      setState(() {
        _yukleniyor = true;
      });

      if (connectivityResult != ConnectivityResult.none) {
        try {
          Kullanici? kullanici =
              await _yetkilendirmeServisi.mailIleKayit(email!, sifre!);
          if (kullanici != null) {
            FirestoreServisi().kullaniciOlustur(
                id: kullanici.id, email: email, adSoyad: adSoyad, sifre: sifre);
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TabBarMain(
                        aktifKullaniciId: kullanici!.id,
                      )));
          // Navigator.pop(context);
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
          uyariGoster(hataKodu: 0);
        });
      }
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
      hataMesaji = "B??yle bir kullan??c?? bulunmuyor.";
    } else if (hataKodu == 360587416) {
      hataMesaji = "Girdi??iniz mail adresi ge??ersizdir.";
    } else if (hataKodu == 185768934) {
      hataMesaji = "Girilen ??ifre hatal??.";
    } else if (hataKodu == 446151799) {
      hataMesaji = "Kullan??c?? engellenmi??.";
    } else if (hataKodu == 0) {
      hataMesaji = "??nternet ba??lant??n??z?? kontrol edin.";
    } else if (hataKodu == 34618382) {
      hataMesaji = "Bu mail adresine kay??tl?? bir kullan??c?? bulunuyor.";
    } else {
      hataMesaji = "Bir hata olu??tu. Birka?? dakika i??inde tekrar deneyin.";
    }

    var snackBar = SnackBar(content: Text('$hataMesaji'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _googleIleGiris() async {
    var _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    var connectivityResult = await (Connectivity().checkConnectivity());

    setState(() {
      _yukleniyor = true;
    });
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

  Widget get _girisYapNavigator => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Zaten hesab??n var m???',
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
                    MaterialPageRoute(builder: (context) => GirisSayfa()));
              },
              child: Text(
                ' Giri?? yap',
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
