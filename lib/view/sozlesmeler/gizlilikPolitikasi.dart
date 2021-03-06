import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GizlilikPolitikasiSayfa extends StatelessWidget {
  const GizlilikPolitikasiSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Text(
                'Gizlilik Politikas─▒',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.height * 0.032,
                  color: Color(0xff252745),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - G├╝venli─činiz bizim i├žin ├Ânemli. Bu sebeple bizimle payla┼čaca─č─▒n─▒z ki┼čisel veriler hassasiyetle korunmaktad─▒r.\n  - Biz, eevent veri sorumlusu olarak, bu gizlilik ve ki┼čisel verilerin korunmas─▒ politikas─▒ ile, hangi ki┼čisel verilerinizin hangi ama├žla i┼členece─či, i┼členen verilerin kimlerle ve neden payla┼č─▒labilece─či, veri i┼čleme y├Ântemimiz ve hukuki sebeplerimiz ile; i┼členen verilerinize ili┼čkin haklar─▒n─▒z─▒n neler oldu─ču hususunda sizleri ayd─▒nlatmay─▒ ama├žl─▒yoruz.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'Toplanan Ki┼čisel Verileriniz, Toplanma Y├Ântemi ve Hukuki Sebebi',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - IP adresiniz ve kullan─▒c─▒ arac─▒s─▒ bilgileriniz, sadece analiz yapmak amac─▒yla ve ├žerezler (cookies) vb. teknolojiler vas─▒tas─▒yla, otomatik veya otomatik olmayan y├Ântemlerle ve bazen de analitik sa─člay─▒c─▒lar, reklam a─člar─▒, arama bilgi sa─člay─▒c─▒lar─▒, teknoloji sa─člay─▒c─▒lar─▒ gibi ├╝├ž├╝nc├╝ taraflardan elde edilerek, kaydedilerek, depolanarak ve g├╝ncellenerek, aram─▒zdaki hizmet ve s├Âzle┼čme ili┼čkisi ├žer├ževesinde ve s├╝resince, me┼čru menfaat i┼čleme ┼čart─▒na dayan─▒larak i┼členecektir.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'Ki┼čisel Verilerinizin ─░┼členme Amac─▒',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - Bizimle payla┼čt─▒─č─▒n─▒z ki┼čisel verileriniz sadece analiz yapmak suretiyle; sundu─čumuz hizmetlerin gerekliliklerini en iyi ┼čekilde yerine getirebilmek, bu hizmetlere sizin taraf─▒n─▒zdan ula┼č─▒labilmesini ve maksiumum d├╝zeyde faydalan─▒labilmesini sa─člamak, hizmetlerimizi, ihtiya├žlar─▒n─▒z do─črultusunda geli┼čtirebilmek ve sizleri daha geni┼č kapsaml─▒ hizmet sa─člay─▒c─▒lar─▒ ile yasal ├žer├ževeler i├žerisinde bulu┼čturabilmek ve kanundan do─čan zorunluluklar─▒n (ki┼čisel verilerin talep halinde adli ve idari makamlarla payla┼č─▒lmas─▒) yerine getirilebilmesi amac─▒yla, s├Âzle┼čme ve hizmet s├╝resince, amac─▒na uygun ve ├Âl├ž├╝l├╝ bir ┼čekilde i┼členecek ve g├╝ncellenecektir.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'Ki┼čisel Verileri ─░┼členen Ki┼či Olarak Haklar─▒n─▒z',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - KVKK madde 11 uyar─▒nca herkes, veri sorumlusuna ba┼čvurarak a┼ča─č─▒daki haklar─▒n─▒ kullanabilir:\n\n a. Ki┼čisel veri i┼členip i┼členmedi─čini ├Â─črenme,\n b. Ki┼čisel verileri i┼členmi┼čse buna ili┼čkin bilgi talep etme,\n c. Ki┼čisel verilerin i┼členme amac─▒n─▒ ve bunlar─▒n amac─▒na uygun kullan─▒l─▒p kullan─▒lmad─▒─č─▒n─▒ ├Â─črenme,\n d. Yurt i├žinde veya yurt d─▒┼č─▒nda ki┼čisel verilerin aktar─▒ld─▒─č─▒ ├╝├ž├╝nc├╝ ki┼čileri bilme,\n e. Ki┼čisel verilerin eksik veya yanl─▒┼č i┼členmi┼č olmas─▒ h├ólinde bunlar─▒n d├╝zeltilmesini isteme,\n f. Ki┼čisel verilerin silinmesini veya yok edilmesini isteme,\n g. (e) ve (f) bentleri uyar─▒nca yap─▒lan i┼člemlerin, ki┼čisel verilerin aktar─▒ld─▒─č─▒ ├╝├ž├╝nc├╝ ki┼čilere bildirilmesini isteme,\n h. ─░┼členen verilerin m├╝nhas─▒ran otomatik sistemler vas─▒tas─▒yla analiz edilmesi suretiyle ki┼činin kendisi aleyhine bir sonucun ortaya ├ž─▒kmas─▒na itiraz etme,\n i. Ki┼čisel verilerin kanuna ayk─▒r─▒ olarak i┼členmesi sebebiyle zarara u─čramas─▒ h├ólinde zarar─▒n giderilmesini talep etme, haklar─▒na sahiptir.\n\n  - Yukar─▒da say─▒lan haklar─▒n─▒z─▒ kullanmak ├╝zere info@eeent..app ├╝zerinden bizimle ileti┼čime ge├žebilirsiniz.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '─░leti┼čim',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - Sizlere hizmet sunabilmek ama├žl─▒ analizler yapabilmek i├žin, sadece gerekli olan ki┼čisel verilerinizin, i┼čbu gizlilik ve ki┼čisel verilerin i┼členmesi politikas─▒ uyar─▒nca i┼členmesini, kabul edip etmemek hususunda tamamen ├Âzg├╝rs├╝n├╝z. Siteyi kullanmaya devam etti─činiz takdirde kabul etmi┼č oldu─čunuz taraf─▒m─▒zca varsay─▒lacak olup, daha ayr─▒nt─▒l─▒ bilgi i├žin bizimle info@eevent.app e-mail adresi ├╝zerinden ileti┼čime ge├žmekten l├╝tfen ├žekinmeyiniz.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.1),
        ],
      )),
    );
  }
}
