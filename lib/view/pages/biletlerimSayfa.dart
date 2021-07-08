import 'package:event_app/model/etkinlik.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:event_app/view/pages/biletDetaySayfa.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BiletlerimSayfa extends StatefulWidget {
  final String? profilSahibiId;
  const BiletlerimSayfa({Key? key, this.profilSahibiId}) : super(key: key);

  @override
  _BiletlerimSayfaState createState() => _BiletlerimSayfaState();
}

class _BiletlerimSayfaState extends State<BiletlerimSayfa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int currentIndex = 1;
  List<Etkinlik> _yaklasanBiletler = [];
  List<Etkinlik> _gecmisBiletler = [];

  Future<void> yaklasanBiletleriGetir() async {
    List<Etkinlik> biletler = await FirestoreServisi()
        .yaklasanBiletleriGetir(aktifKullaniciId: widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _yaklasanBiletler = biletler;
      });
    }
  }

  Future<void> gecmisBiletleriGetir() async {
    List<Etkinlik> biletler = await FirestoreServisi()
        .gecmisBiletleriGetir(aktifKullaniciId: widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _gecmisBiletler = biletler;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    yaklasanBiletleriGetir();
    gecmisBiletleriGetir();
  }

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

  Widget get _yaklasanlarTab => FutureBuilder<List<Etkinlik>>(
        future: FirestoreServisi()
            .yaklasanBiletleriGetir(aktifKullaniciId: widget.profilSahibiId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.length == 0) {
            return Center(
                child: Text(
              "Hiç biletin yok :(",
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Etkinlik etkinlik = snapshot.data![index];
              return buildBilet(etkinlik, false);
            },
          );
        },
      );

  String _guneCevir(Etkinlik etkinlik) {
    String gunTR = '';
    final List<String> aylar = [
      "Ocak",
      "Şubat",
      "Mart",
      "Nisan",
      "Mayıs",
      "Haziran",
      "Temmuz",
      "Ağustos",
      "Eylül",
      "Ekim",
      "Kasım",
      "Aralık"
    ];
    var tarihFull = etkinlik.tarih;
    var parts = tarihFull!.split('/');
    var gunTemp = parts[0];
    var ayTemp = parts[1];
    var yilTemp = parts[2];

    int gun = int.parse(gunTemp);
    int ay = int.parse(ayTemp);
    int yil = int.parse(yilTemp);

    var dt = DateTime.utc(yil, ay, gun); // YYYY - MM - DD
    var newFormat = DateFormat("EEEE");
    String updatedDt = newFormat.format(dt);
    if (updatedDt == 'Monday') {
      gunTR = 'Pzt';
    } else if (updatedDt == 'Tuesday') {
      gunTR = 'Slı';
    } else if (updatedDt == 'Wednesday') {
      gunTR = 'Çrş';
    } else if (updatedDt == 'Thursday') {
      gunTR = 'Prş';
    } else if (updatedDt == 'Friday') {
      gunTR = 'Cma';
    } else if (updatedDt == 'Saturday') {
      gunTR = 'Cmt';
    } else if (updatedDt == 'Sunday') {
      gunTR = 'Pzr';
    }
    return gunTR +
        ', ' +
        gun.toString() +
        ' ' +
        aylar[ay - 1] +
        ' ' +
        yil.toString();
  }

  buildBilet(Etkinlik etkinlik, bool gecmisSecildi) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EtkinlikDetaySayfa(
                      aktifKullaniciId: widget.profilSahibiId,
                      etkinlikData: etkinlik,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Center(
                        child: Image.network(
                      etkinlik.etkinlikResmiUrl.toString(),
                      fit: BoxFit.fill,
                    ))),
                boslukWidth(context, 0.02),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        etkinlik.baslik.toString(),
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Color(0xff252745),
                            fontSize: MediaQuery.of(context).size.height * 0.02,
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
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w400),
                              ),
                              boslukHeight(context, 0.006),
                              Text(
                                _guneCevir(etkinlik),
                                style: TextStyle(
                                    color: gecmisSecildi
                                        ? Color(0xffEF2E5B)
                                        : Color(0xff252745),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 0,
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saat',
                                style: TextStyle(
                                    color: Color(0xff252745),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w400),
                              ),
                              boslukHeight(context, 0.006),
                              Text(
                                etkinlik.saat.toString(),
                                style: TextStyle(
                                    color: gecmisSecildi
                                        ? Color(0xffEF2E5B)
                                        : Color(0xff252745),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          boslukWidth(context, 0.1),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customCardYaklasanlar(
      String baslik, String foto, String tarih, String saat) {
    return InkWell(
      onTap: () {
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

  Widget get _gecmisTab => FutureBuilder<List<Etkinlik>>(
        future: FirestoreServisi()
            .gecmisBiletleriGetir(aktifKullaniciId: widget.profilSahibiId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.length == 0) {
            return Center(
                child: Text(
              "Hiç biletin yok :(",
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Etkinlik etkinlik = snapshot.data![index];
              return buildBilet(etkinlik, true);
            },
          );
        },
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
                      aktifKullaniciId: baslik,
                      //etkinlikData: foto,
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
