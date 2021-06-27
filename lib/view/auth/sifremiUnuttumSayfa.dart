import 'package:event_app/model/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class SifremiUnuttumSayfa extends StatefulWidget {
  const SifremiUnuttumSayfa({Key? key}) : super(key: key);

  @override
  _SifremiUnuttumSayfaState createState() => _SifremiUnuttumSayfaState();
}

class _SifremiUnuttumSayfaState extends State<SifremiUnuttumSayfa> {
  final _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formAnahtari,
          child: Column(
            children: [
              _lottieAnimation,
              boslukHeight(context, 0.01),
              _sifremiUnuttumText,
              boslukHeight(context, 0.01),
              _aciklamaText,
              boslukHeight(context, 0.03),
              _emailTextField,
              boslukHeight(context, 0.03),
              _sifirlaBtn,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _lottieAnimation => Center(
        child: Lottie.asset('assets/lottie/lock.json',
            repeat: false, height: MediaQuery.of(context).size.height * 0.3),
      );

  Widget get _sifremiUnuttumText => Text(
        'Şifreni mi unuttun?',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w800,
          fontSize: MediaQuery.of(context).size.height * 0.04,
          color: Color(0xff252745),
        ),
      );

  Widget get _aciklamaText => Text(
        'Endişelenme, mailine şifreni sıfırlaman için link göndereceğiz. Lütfen mailini gir.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Color(0xff252745).withOpacity(0.7),
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

  Widget get _sifirlaBtn => InkWell(
        onTap: () {
          _sifreyiSifirla();
        },
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
            'Şifremi Sıfırla',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );

  void _sifreyiSifirla() {
    if (_formAnahtari.currentState!.validate()) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
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
    }
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

  Widget get _bottomSheetAciklama => Text(
        'Şifreni sıfırlaman için mail adresine bir link gönderdik.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Color(0xff252745).withOpacity(0.7),
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
