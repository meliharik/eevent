import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eevent/model/duyuru.dart';
import 'package:eevent/model/etkinlik.dart';
import 'package:eevent/model/kullanici.dart';
import 'package:eevent/servisler/firestoreServisi.dart';
import 'package:eevent/view/hepsiniGor/buHaftaHepsiniGorSayfa.dart';
import 'package:eevent/view/hepsiniGor/bugunHepsiniGorSayfa.dart';
import 'package:eevent/view/hepsiniGor/populerHepsiniGorSayfa.dart';
import 'package:eevent/view/pages/duyurularSayfa.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:eevent/view/pages/etkinlikDetaySayfa.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

class AnaSayfa extends StatefulWidget {
  final String? aktifKullaniciId;

  const AnaSayfa({Key? key, this.aktifKullaniciId}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool duyurularGorulduMu = true;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this.firebaseCloudMessagingListeners(context);
    });
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Firebase Device token: $deviceToken");
    });

    try {
      FirestoreServisi()
          .azKaldiDuyuruOlustur(aktifKullaniciId: widget.aktifKullaniciId);
      FirestoreServisi()
          .sikayetDuyuruOlustur(aktifKullaniciId: widget.aktifKullaniciId);
    } on Exception catch (hata) {
      print("hata");
      print(hata.hashCode);
      print(hata);
      var snackBar = SnackBar(
          content:
              Text('Bir hata oluştu. Birkaç dakika içinde tekrar deneyin.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    duyuruKontrol(kullaniciId: widget.aktifKullaniciId);
  }

  @override
  void dispose() {
    duyuruKontrol(kullaniciId: widget.aktifKullaniciId);
    super.dispose();
  }

  duyuruKontrol({String? kullaniciId}) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("duyurular")
        .doc(kullaniciId)
        .collection("kullanicininDuyurulari")
        .get();

    snapshot.docs.forEach((DocumentSnapshot doc) {
      Duyuru duyuru = Duyuru.dokumandanUret(doc);
      FirebaseFirestore.instance
          .collection("duyurular")
          .doc(kullaniciId)
          .collection("kullanicininDuyurulari")
          .doc(duyuru.id)
          .get();
      if (duyuru.gorulduMu == "false") {
        if (mounted) {
          setState(() {
            duyurularGorulduMu = false;
          });
        }
      }
    });
  }

  String _randomTextler() {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                  onPressed: () {
                    FirestoreServisi()
                        .duyuruGuncelle(kullaniciId: widget.aktifKullaniciId);
                    setState(() {
                      duyurularGorulduMu = true;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DuyurularSayfa(
                                  aktifKullaniciId: widget.aktifKullaniciId,
                                )));
                  },
                  icon: Stack(
                    children: [
                      Icon(FontAwesomeIcons.solidBell,
                          color: Theme.of(context).primaryColor),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          decoration: new BoxDecoration(
                            color: Color(0xffEF2E5B),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: duyurularGorulduMu ? 0 : 10,
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
                  boslukHeight(context, 0.01),
                  FutureBuilder(
                    future: FirestoreServisi()
                        .kullaniciGetir(widget.aktifKullaniciId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: LoadingBouncingGrid.square(
                            duration: Duration(milliseconds: 750),
                            size: MediaQuery.of(context).size.height * 0.05,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        );
                      }
                      return _selamText(snapshot.data as Kullanici);
                    },
                  ),
                  boslukHeight(context, 0.01),
                  _randomText,
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
          )),
    );
  }

  _selamText(Kullanici profilData) {
    return Center(
      child: Text(
        "Selam " + _sadeceIsim(profilData).toString(),
        style: TextStyle(
            color: Color(0xff252745),
            fontSize: MediaQuery.of(context).size.height * 0.035,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800),
      ),
    );
  }

  String _sadeceIsim(Kullanici profilData) {
    if (mounted) {
      var isimFull = profilData.adSoyad;
      var parts = isimFull!.split(' ');
      var isim = parts[0].trim();
      return isim;
    }
    return "null";
  }

  Widget get _randomText => Text(
        _randomTextler(),
        style: TextStyle(
            color: Color(0xff252745),
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600),
      );

  Widget get _popularCardlar => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        //width: MediaQuery.of(context).size.width * 0.38,
        child: FutureBuilder<List<Etkinlik>>(
          future: FirestoreServisi().populerEtkinlikleriGetir(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingBouncingGrid.square(
                  duration: Duration(milliseconds: 750),
                  size: MediaQuery.of(context).size.height * 0.05,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (snapshot.data!.length == 0) {
              return Center(child: Text("Popüler olan etkinlik hiç yok :("));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.length > 7 ? 7 : snapshot.data!.length,
              itemBuilder: (context, index) {
                Etkinlik etkinlik = snapshot.data![index];
                return buildCard(etkinlik);
              },
            );
          },
        ),
      );

  Widget get _buHaftaCardlar => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        //width: MediaQuery.of(context).size.width * 0.38,
        child: FutureBuilder<List<Etkinlik>>(
          future: FirestoreServisi().buHaftaEtkinlikleriGetir(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingBouncingGrid.square(
                  duration: Duration(milliseconds: 750),
                  size: MediaQuery.of(context).size.height * 0.05,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (snapshot.data!.length == 0) {
              return Center(child: Text("Bu hafta hiç etkinlik yok :("));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.length > 7 ? 7 : snapshot.data!.length,
              itemBuilder: (context, index) {
                Etkinlik etkinlik = snapshot.data![index];
                return buildCard(etkinlik);
              },
            );
          },
        ),
      );

  Widget get _bugunCardlar => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        //width: MediaQuery.of(context).size.width * 0.38,
        child: FutureBuilder<List<Etkinlik>>(
          future: FirestoreServisi().bugunEtkinlikleriGetir(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingBouncingGrid.square(
                  duration: Duration(milliseconds: 750),
                  size: MediaQuery.of(context).size.height * 0.05,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (snapshot.data!.length == 0) {
              return Center(child: Text("Bugün hiç etkinlik yok :("));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.length > 7 ? 7 : snapshot.data!.length,
              itemBuilder: (context, index) {
                Etkinlik etkinlik = snapshot.data![index];
                return buildCard(etkinlik);
              },
            );
          },
        ),
      );

  String _gunuBulma(Etkinlik etkinlik) {
    if (mounted) {
      var tarihFull = etkinlik.tarih;
      var parts = tarihFull!.split('/');
      var gunTemp = parts[0].trim();
      var parts2 = gunTemp.split('');

      if (parts2[0] == '0') {
        return parts2[1];
      }

      return gunTemp;
    }
    return "null";
  }

  String _ayBulma(Etkinlik etkinlik) {
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
    if (mounted) {
      var tarihFull = etkinlik.tarih;
      var parts = tarihFull!.split('/');
      var ayTemp = parts[1];
      int ay = int.parse(ayTemp);
      return aylar[ay - 1];
    }
    return "null";
  }

  buildCard(Etkinlik etkinlik) {
    return Row(
      children: [
        boslukWidth(context, 0.04),
        Stack(
          children: [
            Card(
              elevation: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EtkinlikDetaySayfa(
                                  aktifKullaniciId: widget.aktifKullaniciId,
                                  etkinlikData: etkinlik,
                                )));
                  },
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      // height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Image.network(
                                etkinlik.etkinlikResmiUrl.toString(),
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: LoadingBouncingGrid.square(
                                      duration: Duration(milliseconds: 750),
                                      size: MediaQuery.of(context).size.height *
                                          0.05,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text('Resim Yüklenemedi'),
                                  );
                                },
                              )),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      etkinlik.baslik.toString(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w800,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        color:
                                            Color(0xff252745).withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      etkinlik.kategori.toString(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                        color:
                                            Color(0xff252745).withOpacity(0.6),
                                      ),
                                    ),
                                    Text(
                                      etkinlik.saat.toString(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
                                        color:
                                            Color(0xff252745).withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Row(
              children: [
                boslukWidth(context, 0.29),
                Column(
                  children: [
                    boslukHeight(context, 0.09),
                    Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            boslukWidth(context, 0.01),
                            Column(
                              children: [
                                Text(
                                  _gunuBulma(etkinlik),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.022,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  _ayBulma(etkinlik),
                                  style: TextStyle(
                                      color: Color(0xff252745),
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            boslukWidth(context, 0.01),
                          ],
                        )),
                  ],
                ),
                //boslukWidth(0.04),
              ],
            )
          ],
        )
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
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PopulerHepsiniGorSayfa(
                            aktifKullaniciId: widget.aktifKullaniciId,
                          )));
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
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BuHaftaHepsiniGorSayfa(
                            aktifKullaniciId: widget.aktifKullaniciId,
                          )));
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
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BugunHepsiniGorSayfa(
                            aktifKullaniciId: widget.aktifKullaniciId,
                          )));
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
