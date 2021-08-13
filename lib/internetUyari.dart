import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:eevent/yonlendirme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InternetUyariSayfa extends StatefulWidget {
  const InternetUyariSayfa({Key? key}) : super(key: key);

  @override
  _InternetUyariSayfaState createState() => _InternetUyariSayfaState();
}

class _InternetUyariSayfaState extends State<InternetUyariSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'eevent',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                color: Theme.of(context).primaryColor,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              boslukHeight(context, 0.08),
              _lottieAnimation,
              boslukHeight(context, 0.05),
              _baslik,
              boslukHeight(context, 0.02),
              _aciklamaText,
              boslukHeight(context, 0.05),
              _yenidenDeneBtn,
            ],
          ),
        ));
  }

  Widget get _lottieAnimation => Center(
        child: Lottie.asset('assets/lottie/no_internet.json',
            frameRate: FrameRate(60),
            repeat: true,
            height: MediaQuery.of(context).size.height * 0.3),
      );

  Widget get _baslik => Row(
        children: [
          boslukWidth(context, 0.04),
          Text(
            'Ooops!',
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800,
              fontSize: MediaQuery.of(context).size.height * 0.04,
              color: Color(0xff252745),
            ),
          ),
          boslukWidth(context, 0.04)
        ],
      );

  Widget get _aciklamaText => Row(
        children: [
          boslukWidth(context, 0.04),
          Expanded(
            child: Text(
              'Sanırım internete bağlı değilsin. Bağlantını kontrol etmeye ne dersin?',
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Color(0xff252745).withOpacity(0.7),
              ),
            ),
          ),
          boslukWidth(context, 0.04),
        ],
      );

  Widget get _yenidenDeneBtn => InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Yonlendirme()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffEF2E5B)),
          child: Center(
              child: Text(
            'Yeniden Dene',
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );
}
