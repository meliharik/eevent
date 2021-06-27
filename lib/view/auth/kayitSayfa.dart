import 'package:event_app/model/tabbar_view.dart';
import 'package:event_app/model/widthAndHeight.dart';
import 'package:event_app/view/auth/girisSayfa.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  _KayitSayfaState createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  bool isObscureTextTrue = true;
  final _formAnahtari = GlobalKey<FormState>();
  bool _yukleniyor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          _adSoyadTextField,
          boslukHeight(context, 0.03),
          _emailTextField,
          boslukHeight(context, 0.03),
          _sifreTextField,
          boslukHeight(context, 0.03),
          _girisYapBtn,
          boslukHeight(context, 0.03),
          _googleGirisBtn,
          _expandedHeight,
          _girisYapNavigator,
          boslukHeight(context, 0.05),
        ],
      ),
    );
  }

  Widget get _welcomeText => Row(children: [
        boslukWidth(context, 0.04),
        SafeArea(
          child: Text(
            'Hesap Oluştur,',
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
            'Kayıt ol ve aramıza katıl!',
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
              return 'Ad Soyad alanı boş bırakılamaz!';
            } else if (input.contains(',') ||
                input.contains('.') ||
                input.contains('*')) {
              print(input.toString());
              return 'Lütfen noktalama işareti kullanmayın.';
            }
            return null;
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
              return 'Email alanı boş bırakılamaz!';
            } else if (!input.contains('@')) {
              return 'Girilen değer mail formatında olmalı';
            }
            return null;
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
        ),
      );

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
            'Hesap Oluştur',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );

  Widget get _expandedHeight => Expanded(
          child: SizedBox(
        child: Text(''),
      ));

  void _girisYap() {
    if (_formAnahtari.currentState!.validate()) {
      setState(() {
        _yukleniyor = true;
      });
    }
  }

  Widget get _googleGirisBtn => InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TabBarMain()));
        },
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
                  'Google ile Hesap Oluştur',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Color(0xff252745)),
                ),
              )
            ])),
      );

  Widget get _girisYapNavigator => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Zaten hesabın var mı?',
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
                ' Giriş yap',
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
