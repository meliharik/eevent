import 'package:event_app/model/sikayet.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lottie/lottie.dart';

class SikayetDetaySayfa extends StatelessWidget {
  final String? aktfifKullaniciId;
  final String? sikayetId;
  const SikayetDetaySayfa({Key? key, this.aktfifKullaniciId, this.sikayetId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _lottieAnimation(context),
            _welcomeText(context),
            _devamEtText(context),
            boslukHeight(context, 0.03),
            _sikayetMetninText(context),
            _sikayetMetni,
            boslukHeight(context, 0.03),
            _degerlendirmemizText(context),
            _degerlendiremiz
          ],
        ),
      ),
    );
  }

  _degerlendirmemizText(BuildContext context) {
    return Row(
      children: [
        boslukWidth(context, 0.04),
        Text(
          'Değerlendirmemiz:',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * 0.025,
            color: Color(0xff252745),
          ),
        )
      ],
    );
  }

  _sikayetMetninText(BuildContext context) {
    return Row(
      children: [
        boslukWidth(context, 0.04),
        Text(
          'Şikayet metnin:',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * 0.025,
            color: Color(0xff252745),
          ),
        )
      ],
    );
  }

  Widget get _sikayetMetni => FutureBuilder(
        future: FirestoreServisi().sikayetGetir(
            aktifKullaniciId: aktfifKullaniciId, sikayetId: sikayetId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingBouncingGrid.square(
                                      duration: Duration(milliseconds: 750),
                                      size: MediaQuery.of(context).size.height *
                                          0.05,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),);
          }
          Sikayet sikayet = snapshot.data as Sikayet;
          return SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    boslukWidth(context, 0.04),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sikayet.sikayetMetni.toString(),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.023,
                              color: Color(0xff252745),
                            ),
                          )
                        ],
                      ),
                    ),
                    boslukWidth(context, 0.04),
                  ],
                ),
              ],
            ),
          );
        },
      );

  _lottieAnimation(BuildContext context) {
    return Lottie.asset('assets/lottie/control.json',
        repeat: false, height: MediaQuery.of(context).size.height * 0.3);
  }

  Widget get _degerlendiremiz => FutureBuilder(
        future: FirestoreServisi().sikayetGetir(
            aktifKullaniciId: aktfifKullaniciId, sikayetId: sikayetId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingBouncingGrid.square(
                                      duration: Duration(milliseconds: 750),
                                      size: MediaQuery.of(context).size.height *
                                          0.05,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),);
          }
          Sikayet sikayet = snapshot.data as Sikayet;
          return SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    boslukWidth(context, 0.04),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sikayet.sikayetCevabi.toString(),
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.023,
                              color: Color(0xff252745),
                            ),
                          )
                        ],
                      ),
                    ),
                    boslukWidth(context, 0.04),
                  ],
                ),
              ],
            ),
          );
        },
      );

  Widget _welcomeText(BuildContext context) {
    return Row(children: [
      boslukWidth(context, 0.04),
      SafeArea(
        child: Text(
          'Şikayetini değerlendirdik.',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800,
            fontSize: MediaQuery.of(context).size.height * 0.03,
            color: Color(0xff252745),
          ),
        ),
      )
    ]);
  }

  Widget _devamEtText(BuildContext context) {
    return Row(
      children: [
        boslukWidth(context, 0.04),
        Text(
          'Değerli görüşün için teşekkür ederiz.',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * 0.027,
            color: Color(0xff252745).withOpacity(0.7),
          ),
        )
      ],
    );
  }
}
