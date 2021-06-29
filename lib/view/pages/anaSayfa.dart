import 'dart:math';

import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _randomText() {
    var _random = Random();
    final List<String> textler = [
      'Bugün neler öğrenmek istiyorsun?',
      'Bakalım bugün kimleri tanıyacaksın.',
      'Sana gaz veren şeyi buldun mu?',
      'Sana ilham veren o şeyi buldun mu?',
      'Bizce bugün çok güzel etkinlikler var.',
      'O fikri ne zaman hayata geçireceksin?',
      'Bugün çok güzel konuşmalar varmış.'
    ];

    return textler[_random.nextInt(7)]; // 0 - 7
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
                onPressed: () {
                  // TODO: bildirimler sekmesine gidecek
                  print("bildirimler sekmesine gidecek.");
                },
                icon: Stack(
                  children: [
                    Icon(FontAwesomeIcons.solidBell,
                        color: Theme.of(context).primaryColor),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Color(0xffEF2E5B),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 10,
                        width: 10,
                      ),
                    )
                  ],
                ))
          ],
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Selam Melih',
                  style: TextStyle(
                      color: Color(0xff252745),
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800),
                ),
                boslukHeight(context, 0.01),
                Text(
                  _randomText(),
                  style: TextStyle(
                      color: Color(0xff252745),
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600),
                ),
                boslukHeight(context, 0.02),
                _populerRow,
                boslukHeight(context, 0.01),
                _popularCardlar,
                boslukHeight(context, 0.03),
                _buHaftaRow,
                boslukHeight(context, 0.01),
                _buHaftaCardlar,
                boslukHeight(context, 0.03),
                _bugunRow,
                boslukHeight(context, 0.01),
                _bugunCardlar,
                boslukHeight(context, 0.05)
              ],
            ),
          ),
        ));
  }

  Widget get _popularCardlar => Container(
        height: MediaQuery.of(context).size.height * 0.33,
        //width: MediaQuery.of(context).size.width * 0.38,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            customCard('Mobil Programlama', 'Yazılım & Tasarım',
                '01:00 - 17:00', 'mobil', 'Ocak', 07),
            customCard('Yapay Zeka 101', 'Yazılım & Yapay Zeka',
                '12:00 - 15:00', 'robot', 'Aralık', 29),
            customCard('Wine Tasting', 'Wine & Design', '07:30 PM - 09:00 PM',
                'wine', 'Ağustos', 30),
          ],
        ),
      );

  Widget get _buHaftaCardlar => Container(
        height: MediaQuery.of(context).size.height * 0.33,
        //width: MediaQuery.of(context).size.width * 0.38,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            customCard('Hatalar Nasıl\nDüzeltilmez', 'Yazılım & Tasarım',
                '01:00 - 17:00', 'hataDuzeltme', 'Mayıs', 26),
            customCard('Network oluşturma', 'Global & Gelişim', '12:00 - 15:00',
                'network', 'Mayıs', 29),
            customCard('Wine Tasting', 'Wine & Design', '07:30 PM - 09:00 PM',
                'cooking', 'Mayıs', 23),
          ],
        ),
      );

  Widget get _bugunCardlar => Container(
        height: MediaQuery.of(context).size.height * 0.33,
        //width: MediaQuery.of(context).size.width * 0.38,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            customCard('Yapay Zeka Üzerine\nSohbet', 'Mutfak & Yemek',
                '01:00 - 17:00', 'robot', 'Temmuz', 18),
            customCard('Network oluşturma', 'Global & Gelişim', '12:00 - 15:00',
                'network', 'Temmuz', 18),
            customCard('Wine Tasting', 'Wine & Design', '07:30 PM - 09:00 PM',
                'wine', 'Temmuz', 18),
          ],
        ),
      );

  Widget customCard(String baslik, String kategori, String saat, String foto,
      String ay, int gun) {
    return Row(
      children: [
        boslukWidth(context, 0.02),
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EtkinlikDetaySayfa(
                              baslik: baslik,
                              foto: foto,
                            )));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Center(
                            child: Image.asset(
                              "assets/images/$foto.png",
                              //fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              boslukWidth(context, 0.03),
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boslukHeight(context, 0.023),
                                  Wrap(
                                    children: [
                                      Text(
                                        '$baslik',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w800,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          color: Color(0xff252745),
                                        ),
                                      ),
                                    ],
                                  ),
                                  boslukHeight(context, 0.006),
                                  Text(
                                    '$kategori',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: Color(0xff252745).withOpacity(0.8),
                                    ),
                                  ),
                                  boslukHeight(context, 0.0066),
                                  Text(
                                    '$saat',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: Color(0xff252745).withOpacity(0.8),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Column(
                                children: [
                                  Expanded(child: SizedBox()),
                                  Icon(
                                    FontAwesomeIcons.heart,
                                    size: MediaQuery.of(context).size.height *
                                        0.022,
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                  boslukHeight(context, 0.03),
                                ],
                              ),
                              boslukWidth(context, 0.035)
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                boslukWidth(context, 0.5),
                Column(
                  children: [
                    boslukHeight(context, 0.12),
                    Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            boslukWidth(context, 0.02),
                            Column(
                              children: [
                                Text(
                                  '$gun',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '$ay',
                                  style: TextStyle(
                                      color: Color(0xff252745),
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            boslukWidth(context, 0.02),
                          ],
                        )),
                  ],
                ),
                //boslukWidth(0.04),
              ],
            )
          ],
        ),
        boslukWidth(context, 0.02)
      ],
    );
  }

  Widget get _populerRow => Row(
        children: [
          boslukWidth(context, 0.04),
          Text(
            'Popüler',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.045,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            //TODO: popüler sayfaya geçecek
            onTap: () {
              print("popüler olanların olduğu sayfaya gidecek.");
            },
            child: Text(
              'Hepsini Gör',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
          ),
          boslukWidth(context, 0.04)
        ],
      );

  Widget get _buHaftaRow => Row(
        children: [
          boslukWidth(context, 0.04),
          Text(
            'Bu Hafta',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.045,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            //TODO: bu haftakilerin olduğu sayfa
            onTap: () {
              print("bu haftakilerin olduğu sayfaya gidecek.");
            },
            child: Text(
              'Hepsini Gör',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
          ),
          boslukWidth(context, 0.04)
        ],
      );

  Widget get _bugunRow => Row(
        children: [
          boslukWidth(context, 0.04),
          Text(
            'Bugün',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.045,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            //TODO: bugünkilerin olduğu sayfa
            onTap: () {
              print("bugünkilerin olduğu sayfaya gidecek.");
            },
            child: Text(
              'Hepsini Gör',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
          ),
          boslukWidth(context, 0.04)
        ],
      );
}
