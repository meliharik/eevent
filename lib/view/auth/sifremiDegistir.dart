import 'package:event_app/model/kullanici.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class SifremiDegistirSayfa extends StatefulWidget {
  final Kullanici profilSahibiId;

  const SifremiDegistirSayfa({Key? key, required this.profilSahibiId})
      : super(key: key);

  @override
  _SifremiDegistirSayfaState createState() => _SifremiDegistirSayfaState();
}

class _SifremiDegistirSayfaState extends State<SifremiDegistirSayfa> {
  String? mevcutSifre;
  String? yeniSifre;
  bool isObscureTextTrue = true;
  bool isObscureTextTrue2 = true;
  bool _yukleniyor = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Şifremi Değiştir',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
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
          children: [
            _yuklemeAnimasyonu(),
            _sayfaElemanlari,
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

  Widget get _sayfaElemanlari => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _lottieAnimation,
              _mevcutSifreTextField,
              boslukHeight(context, 0.015),
              _yeniSifreTextField,
              boslukHeight(context, 0.02),
              _kaydetBtn,
            ],
          ),
        ),
      );

  Widget get _lottieAnimation => Center(
        child: Lottie.asset('assets/lottie/lock_loading.json',
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.3),
      );

  Widget get _mevcutSifreTextField => Padding(
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
            hintText: 'Mevcut Şifre',
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
            }
            return null;
          },
          onSaved: (girilenDeger) {
            mevcutSifre = girilenDeger;
          },
        ),
      );

  Widget get _yeniSifreTextField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            color: Color(0xff252745),
          ),
          obscureText: isObscureTextTrue2,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: isObscureTextTrue2
                    ? Icon(FontAwesomeIcons.eye)
                    : Icon(FontAwesomeIcons.eyeSlash),
                onPressed: () {
                  setState(() {
                    isObscureTextTrue2 = !isObscureTextTrue2;
                  });
                },
              ),
            ),
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(),
            hintText: 'Yeni Şifre',
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
              return 'Yeni şifre 4 karakterden az olamaz';
            }
            return null;
          },
          onSaved: (girilenDeger) {
            yeniSifre = girilenDeger;
          },
        ),
      );

  Widget get _kaydetBtn => InkWell(
        onTap: _sifreDegistir,
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
            'Kaydet',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );

  _sifreDegistir() async {
    var _formState = _formKey.currentState;
    if (_formState!.validate()) {
      _formState.save();
      FocusScope.of(context).unfocus();

      setState(() {
        _yukleniyor = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email as String, password: mevcutSifre as String);

      if (mevcutSifre.toString() == yeniSifre) {
        setState(() {
          _yukleniyor = false;
        });
        uyariGoster(hataKodu: 1);
      } else {
        try {
          await user.reauthenticateWithCredential(cred);
          try {
            await user.updatePassword(yeniSifre!);
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
                      Lottie.asset('assets/lottie/tick.json',
                          repeat: false,
                          height: MediaQuery.of(context).size.height * 0.25),
                      _bottomSheetBasarili,
                      _bottomSheetAciklama,
                      boslukHeight(context, 0.04),
                      _tamamBtn,
                    ],
                  );
                });
          } catch (error) {
            print("hata");
            print(error.hashCode);
            print(error);
            setState(() {
              _yukleniyor = false;
            });
            uyariGoster(hataKodu: error.hashCode);
          }
        } catch (hata) {
          print("hata");
          print(hata.hashCode);
          print(hata);
          setState(() {
            _yukleniyor = false;
          });
          uyariGoster(hataKodu: hata.hashCode);
        }
      }
    }
  }

  uyariGoster({hataKodu}) {
    String? hataMesaji;

    if (hataKodu == 287540269) {
      hataMesaji =
          "Çok fazla denediniz. Lütfen bir süre bekleyip tekrar deneyin";
    } else if (hataKodu == 185768934) {
      hataMesaji = "Mevcut şifre alanı hatalı.";
    } else if (hataKodu == 265778269) {
      hataMesaji = "Daha zor bir şifre tercih edin.";
    } else if (hataKodu == 1) {
      hataMesaji = "Girilen şifreler aynı.";
    } else {
      hataMesaji = "Bir hata oluştu.";
    }

    var snackBar = SnackBar(content: Text('$hataMesaji'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget get _bottomSheetBasarili => Text(
        'Başarılı',
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
          'Şifren başarılı bir şekilde değiştirildi.',
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
                  colors: [Theme.of(context).primaryColor, Color(0xff6aa9c2)])),
          child: Center(
              child: Text(
            'Tamam',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );
}
