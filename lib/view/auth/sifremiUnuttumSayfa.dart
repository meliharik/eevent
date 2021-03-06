import 'package:eevent/servisler/yetkilendirmeServisi.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SifremiUnuttumSayfa extends StatefulWidget {
  const SifremiUnuttumSayfa({Key? key}) : super(key: key);

  @override
  _SifremiUnuttumSayfaState createState() => _SifremiUnuttumSayfaState();
}

class _SifremiUnuttumSayfaState extends State<SifremiUnuttumSayfa> {
  final _formAnahtari = GlobalKey<FormState>();

  bool _yukleniyor = false;
  String? _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formAnahtari,
          child: Column(
            children: [
              _yukleniyor
                  ? LinearProgressIndicator()
                  : SizedBox(
                      height: 0,
                    ),
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
        '??ifreni mi unuttun?',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w800,
          fontSize: MediaQuery.of(context).size.height * 0.04,
          color: Color(0xff252745),
        ),
      );

  Widget get _aciklamaText => Text(
        'Endi??elenme, mailine ??ifreni s??f??rlaman i??in link g??nderece??iz. L??tfen mailini gir.',
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
              return 'Email alan?? bo?? b??rak??lamaz!';
            } else if (!input.contains('@')) {
              return 'Girilen de??er mail format??nda olmal??';
            }
            return null;
          },
          onSaved: (girilenDeger) {
            _email = girilenDeger;
          },
        ),
      );

  Widget get _sifirlaBtn => InkWell(
        onTap: _sifreyiSifirla,
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
            '??ifremi S??f??rla',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );

  void _sifreyiSifirla() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    if (_formAnahtari.currentState!.validate()) {
      _formAnahtari.currentState!.save();
      FocusScope.of(context).unfocus();

      setState(() {
        _yukleniyor = true;
      });
      try {
        await _yetkilendirmeServisi.sifremiSifirla(_email!);
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
                  Lottie.asset('assets/lottie/email_sent.json',
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
        uyariGoster(hataKodu: hata.hashCode);
      }
    }
  }

  uyariGoster({hataKodu}) {
    String? hataMesaji;

    if (hataKodu == 360587416) {
      hataMesaji = "Girdi??iniz mail adresi ge??ersizdir.";
    } else if (hataKodu == 34618382) {
      hataMesaji = "Girdi??iniz mail kay??tl??d??r.";
    } else if (hataKodu == 265778269) {
      hataMesaji = "Daha zor bir ??ifre tercih edin.";
    } else if (hataKodu == 505284406) {
      hataMesaji = "Bu mail adresine kay??tl?? bir kullan??c?? bulunmuyor.";
    } else {
      hataMesaji = "Bir hata olu??tu. Birka?? dakika i??inde tekrar deneyin.";
    }

    var snackBar = SnackBar(content: Text('$hataMesaji'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget get _bottomSheetBasarili => Text(
        'Ba??ar??l??',
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
          '??ifreni s??f??rlaman i??in mail adresine bir link g??nderdik. E??er maili g??remezsen, spam kutusuna bakmay?? unutma.',
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
