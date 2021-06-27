import 'package:event_app/model/widthAndHeight.dart';
import 'package:event_app/view/pages/biletDetaySayfa.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:flutter/material.dart';

class BiletlerimSayfa extends StatefulWidget {
  const BiletlerimSayfa({Key? key}) : super(key: key);

  @override
  _BiletlerimSayfaState createState() => _BiletlerimSayfaState();
}

class _BiletlerimSayfaState extends State<BiletlerimSayfa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 5,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Biletlerim',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: 25,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            isScrollable: false,
            labelStyle: TextStyle(
                color: Color(0xff252745),
                fontSize: 20,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600),
            tabs: [
              _defaultTab('Geçmiş', 0),
              _defaultTab('Yaklaşanlar', 1),
              _defaultTab('Beğeniler', 2),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _gecmisTab,
                    _yaklasanlarTab,
                    _begenilerTab,
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _defaultTab(String txt, int index) {
    return Tab(
      child: AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
        child: Text('$txt'),
        style: TextStyle(
            color: currentIndex == index
                ? Color(0xff252745)
                : Color(0xff252745).withOpacity(0.6),
            fontSize: currentIndex == index ? 21 : 20,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget get _yaklasanlarTab => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: [
              _customCardYaklasanlar('Hatalar nasıl düzeltilmez', 'ornek1',
                  '22 Temmuz 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
              _customCardYaklasanlar('80 yılda öğrendiklerim', 'ornek2',
                  '21 Haziran 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
              _customCardYaklasanlar('Wine Tasting', 'cooking',
                  '21 Haziran 2021, Pzr', '12:00 - 13:00'),
              _customDivider,
              _customCardYaklasanlar('Mühendislik için\nokul şart mı?',
                  'hataDuzeltme', '26 Mayıs 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
              _customCardYaklasanlar('Mobil Programlama', 'mobil',
                  '21 Haziran 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
              _customCardYaklasanlar('Network oluşturma', 'network',
                  '19 Ağustos 1987, Cma', '10:00 - 13:00'),
              _customDivider,
              _customCardYaklasanlar('Yapay Zeka 101', 'robot',
                  '29 Nisan 2021, Cmt', '10:00 - 13:00'),
            ],
          ),
        ),
      );

  Widget _customCardYaklasanlar(
      String baslik, String foto, String tarih, String saat) {
    return InkWell(
      onTap: () {
        //TODO: bilet detay sayfasına gidecek
        // qr code site linki https://qrcode.tec-it.com/en
        print('bilet detay sayfasına gidecek');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BiletDetaySayfa(
                      baslik: baslik,
                      foto: foto,
                    )));
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.135,
                  child: Center(
                      child: Image.asset(
                    'assets/images/$foto.png',
                    fit: BoxFit.fill,
                  ))),
              boslukWidth(context, 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$baslik',
                    style: TextStyle(
                        color: Color(0xff252745),
                        fontSize: 20,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w800),
                  ),
                  boslukHeight(context, 0.006),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tarih',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 13,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w400),
                          ),
                          boslukHeight(context, 0.006),
                          Text(
                            '$tarih',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 15,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      boslukWidth(context, 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saat',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 13,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w400),
                          ),
                          boslukHeight(context, 0.006),
                          Text(
                            '$saat',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 15,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _gecmisTab => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: [
              _customCardGecmis('Vakit geliyor geçiyor', 'ornek1',
                  '22 Temmuz 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
            ],
          ),
        ),
      );

  Widget _customCardGecmis(
      String baslik, String foto, String tarih, String saat) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.135,
                child: Center(
                    child: Image.asset(
                  'assets/images/$foto.png',
                  fit: BoxFit.fill,
                ))),
            boslukWidth(context, 0.03),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$baslik',
                  style: TextStyle(
                      color: Color(0xff252745),
                      fontSize: 20,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800),
                ),
                boslukHeight(context, 0.006),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tarih',
                          style: TextStyle(
                              color: Color(0xff252745),
                              fontSize: 13,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400),
                        ),
                        boslukHeight(context, 0.006),
                        Text(
                          '$tarih',
                          style: TextStyle(
                              color: Color(0xffEF2E5B),
                              fontSize: 15,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    boslukWidth(context, 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saat',
                          style: TextStyle(
                              color: Color(0xff252745),
                              fontSize: 13,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400),
                        ),
                        boslukHeight(context, 0.006),
                        Text(
                          '$saat',
                          style: TextStyle(
                              color: Color(0xff252745),
                              fontSize: 15,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget get _begenilerTab => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: [
              _customCardBegeniler('Mühendislik için\nokul şart mı?',
                  'hataDuzeltme', '26 Mayıs 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
              _customCardBegeniler('Mobil Programlama', 'mobil',
                  '21 Haziran 2021, Pzr', '10:00 - 13:00'),
              _customDivider,
              _customCardBegeniler('Network oluşturma', 'network',
                  '19 Ağustos 1987, Cma', '10:00 - 13:00'),
              _customDivider,
              _customCardBegeniler('Yapay Zeka 101', 'robot',
                  '29 Nisan 2021, Cmt', '10:00 - 13:00'),
              _customDivider,
              _customCardBegeniler('Resimdeki adam kim aq', 'ornek1',
                  '19 Ağustos 1987, Cma', '10:00 - 13:00'),
              _customDivider,
            ],
          ),
        ),
      );

  Widget _customCardBegeniler(
      String baslik, String foto, String tarih, String saat) {
    return InkWell(
      onTap: () {
        //TODO: etkinlik detay sayfasına gidecek, kalp dolu olacak
        print('etkinlik detay sayfasına gidecek, kalp dolu olacak');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EtkinlikDetaySayfa(
                      baslik: baslik,
                      foto: foto,
                    )));
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.135,
                  child: Center(
                      child: Image.asset(
                    'assets/images/$foto.png',
                    fit: BoxFit.fill,
                  ))),
              boslukWidth(context, 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$baslik',
                    style: TextStyle(
                        color: Color(0xff252745),
                        fontSize: 20,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w800),
                  ),
                  boslukHeight(context, 0.006),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tarih',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 13,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w400),
                          ),
                          boslukHeight(context, 0.006),
                          Text(
                            '$tarih',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 15,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      boslukWidth(context, 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saat',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 13,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w400),
                          ),
                          boslukHeight(context, 0.006),
                          Text(
                            '$saat',
                            style: TextStyle(
                                color: Color(0xff252745),
                                fontSize: 15,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _customDivider => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(
          height: MediaQuery.of(context).size.height * 0.01,
          color: Theme.of(context).primaryColor,
        ),
      );
}
