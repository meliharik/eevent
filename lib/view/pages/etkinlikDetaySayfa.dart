import 'package:eevent/model/etkinlik.dart';
import 'package:eevent/servisler/firestoreServisi.dart';
import 'package:eevent/servisler/notificationServisi.dart';
import 'package:eevent/view/pages/sikayetEtSayfa.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:timezone/data/latest.dart' as tz;

class EtkinlikDetaySayfa extends StatefulWidget {
  final String? aktifKullaniciId;
  final Etkinlik? etkinlikData;
  const EtkinlikDetaySayfa({Key? key, this.aktifKullaniciId, this.etkinlikData})
      : super(key: key);

  @override
  _EtkinlikDetaySayfaState createState() => _EtkinlikDetaySayfaState();
}

class _EtkinlikDetaySayfaState extends State<EtkinlikDetaySayfa> {
  bool _biletVarMi = false;
  bool _begenildiMi = false;
  bool _yukleniyor = false;
  bool _suresiGecmisMi = false;
  bool interneteBagliMi = true;

  _sureKontrol() {
    var now = new DateTime.now();

    DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm').parse(
        widget.etkinlikData!.tarih.toString() +
            ' ' +
            widget.etkinlikData!.saat.toString());

    if (etkinlikZamani.hour == 00) {
      etkinlikZamani = DateTime(etkinlikZamani.year, etkinlikZamani.month,
          etkinlikZamani.day, 12, etkinlikZamani.minute);
    }

    if (etkinlikZamani.isBefore(now)) {
      setState(() {
        _suresiGecmisMi = true;
      });
    }
  }

  _biletKontrol() async {
    bool biletVarMi = await FirestoreServisi().biletVarMi(
        aktifKullaniciId: widget.aktifKullaniciId,
        etkinlikId: widget.etkinlikData!.id);
    setState(() {
      _biletVarMi = biletVarMi;
    });
  }

  _begeniKontrol() async {
    bool begeniVarMi = await FirestoreServisi().begeniVarMi(
        aktifKullaniciId: widget.aktifKullaniciId,
        etkinlikId: widget.etkinlikData!.id);
    setState(() {
      _begenildiMi = begeniVarMi;
    });
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _biletKontrol();
    _begeniKontrol();
    _sureKontrol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _yeriniAyirtBtn,
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
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
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                  "Payla??",
                                  style: TextStyle(
                                      color: Color(0xff252745),
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.022,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w600),
                                ),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text("??ikayet Et",
                                    style: TextStyle(
                                        color: Color(0xff252745),
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.022,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w600)),
                                value: 2,
                              )
                            ],
                            onSelected: (int menu) {
                              if (menu == 1) {
                                _paylas(context);
                              } else if (menu == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SikayetEtSayfa(
                                              aktifKullaniciId:
                                                  widget.aktifKullaniciId,
                                            )));
                              }
                            },
                            child: Icon(
                              FontAwesomeIcons.ellipsisV,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      //boslukWidth(context, 0.035),
                    ],
                    expandedHeight: 300.0,
                    elevation: 0,
                    floating: false,
                    snap: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Image.network(
                          widget.etkinlikData!.etkinlikResmiUrl.toString(),
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: LoadingBouncingGrid.square(
                                duration: Duration(milliseconds: 750),
                                size: MediaQuery.of(context).size.height * 0.05,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text('Resim Y??klenemedi'),
                            );
                          },
                        )),
                  ),
                ];
              },
              body: Stack(
                children: [
                  _yuklemeAnimasyonu(),
                  _sayfaElemanlari,
                ],
              )),
        ));
  }

  void _paylas(BuildContext context) {
    //TODO: <APP_LINK> yerine uygulaman??n store linki olacak
    final String? text =
        "${widget.etkinlikData!.baslik} isimli etkinlik baya ????retici ve zevkli gibi duruyor. Ne dersin, beraber girelim mi konu??maya? Sen de evde bo?? bo?? oturaca????ma kendimi geli??tireyim diyorsan hadi uygulamay?? y??kle.\nhttps://play.google.com/store/apps/details?id=app.eevent.eevent";

    Share.share(text.toString(), subject: 'Uygulamay?? indir!');
  }

  Widget _yuklemeAnimasyonu() {
    if (_yukleniyor) {
      return Center(
        child: LoadingBouncingGrid.square(
          duration: Duration(milliseconds: 750),
          size: MediaQuery.of(context).size.height * 0.05,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return Center();
    }
  }

  Widget get _sayfaElemanlari => SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boslukHeight(context, 0.03),
                _baslikVeKalp(),
                boslukHeight(context, 0.03),
                _etkinlikZaman(),
                boslukHeight(context, 0.02),
                //  t??m etkinlikler online olaca???? i??in iptal edildi
                //_etkinlikYer(),
                //boslukHeight(context, 0.02),
                _etkinlikFiyat(),
                boslukHeight(context, 0.025),
                _etkinlikSertifika(),
                boslukHeight(context, 0.025),
                _etkinlikKontenjan(),
                boslukHeight(context, 0.025),
                _aciklamaBaslik,
                boslukHeight(context, 0.01),
                _aciklamaText,
                boslukHeight(context, 0.15),
              ],
            ),
          ),
        ),
      );

  Widget get _yeriniAyirtBtn => InkWell(
        onTap: biletAlma,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: _suresiGecmisMi
                  ? Color(0xffEF2E5B)
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(butonText(),
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600))),
        ),
      );

  String butonText() {
    if (_biletVarMi) {
      if (_suresiGecmisMi) {
        return 'Biletinizin s??resi ge??mi??';
      } else {
        return 'Biletin Haz??r';
      }
    } else {
      if (_suresiGecmisMi) {
        return ' Etkinli??in s??resi ge??mi??';
      } else {
        return 'Yerini Ay??rt';
      }
    }
  }

  notificationIcinTarih() {
    var simdi = DateTime.now();

    var saatFull = widget.etkinlikData!.saat;
    var saatParts = saatFull!.split(":");
    var saatTemp = saatParts[0];
    var dakikaTemp = saatParts[1];

    int saat = int.parse(saatTemp);
    int dakika = int.parse(dakikaTemp);

    var tarihFull = widget.etkinlikData!.tarih;
    var parts = tarihFull!.split('/');
    var gunTemp = parts[0];
    var ayTemp = parts[1];
    var yilTemp = parts[2];

    // ignore: unrelated_type_equality_checks
    if (ayTemp[0] == 0) {
      ayTemp = ayTemp[1];
    }

    int gun = int.parse(gunTemp);
    int ay = int.parse(ayTemp);
    // ignore: unused_local_variable
    int yil = int.parse(yilTemp);

    int toplamSaniyeEtkinlik = ((30 * ay) + gun) * 24 * 3600;
    int cikarilacakSaniyeEtkinlik = (24 - saat) * 3600;
    int totalSaniyeEtkinlik =
        toplamSaniyeEtkinlik - cikarilacakSaniyeEtkinlik + dakika * 60;
    int yarimSaatOncesi = totalSaniyeEtkinlik - 30 * 60;

    int toplamSaniyeNow = ((30 * simdi.month) + simdi.day) * 24 * 3600;
    int cikarilacakSaniyeNow = (24 - simdi.hour) * 3600;
    int totalSaniyeNow =
        toplamSaniyeNow - cikarilacakSaniyeNow + simdi.minute * 60;

    // print("etkinlik: " + totalSaniyeEtkinlik.toString());
    // print("now: " + totalSaniyeNow.toString());
    // print(yarimSaatOncesi - totalSaniyeNow);
    if ((yarimSaatOncesi - totalSaniyeNow) >= 0) {
      return yarimSaatOncesi - totalSaniyeNow;
    } else {
      return 5;
    }
  }

  Future biletAlma() async {
    notificationIcinTarih();
    if (_suresiGecmisMi == false) {
      if (_biletVarMi == false) {
        setState(() {
          _yukleniyor = true;
        });
        try {
          FirestoreServisi().biletOlustur(
              aktifKullaniciId: widget.aktifKullaniciId,
              etkinlikId: widget.etkinlikData!.id);
          FirestoreServisi().populerlikSayisiArtir(widget.etkinlikData!.id);
          setState(() {
            _yukleniyor = false;
            _biletVarMi = true;
          });
          NotificationService().showNotification(
              widget.etkinlikData!.id.hashCode,
              "??ok Az Kald??!",
              widget.etkinlikData!.baslik.toString() +
                  ' ba??l??kl?? biletin yar??m saat i??inde ba??layacak. Haydi ko??!',
              notificationIcinTarih());

          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    boslukHeight(context, 0.02),
                    Center(
                      child: Lottie.asset('assets/lottie/ticket.json',
                          repeat: false,
                          height: MediaQuery.of(context).size.height * 0.2),
                    ),
                    _bottomSheetBasarili(true),
                    boslukHeight(context, 0.02),
                    _bottomSheetAciklama(true),
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
          var snackBar = SnackBar(
              content: Text(
                  'Bir hata olu??tu. Birka?? dakika i??inde tekrar deneyin.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        var snackBar = SnackBar(
            content: Text(
                'Biletlerim sekmesinden biletinizi g??r??nt??leyebilirsiniz.'));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          context: context,
          builder: (context) {
            return Column(
              children: [
                boslukHeight(context, 0.01),
                Container(
                  height: 8,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Lottie.asset('assets/lottie/time.json',
                    height: MediaQuery.of(context).size.height * 0.25),
                _bottomSheetBasarili(false),
                boslukHeight(context, 0.02),
                _bottomSheetAciklama(false),
                boslukHeight(context, 0.04),
                _tamamBtn,
              ],
            );
          });
    }
  }

  Widget _bottomSheetBasarili(bool basariliMi) {
    return Text(
      basariliMi ? 'Ba??ar??l??' : 'Ba??ar??s??z',
      style: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w800,
        fontSize: MediaQuery.of(context).size.height * 0.035,
        color: Color(0xff252745),
      ),
    );
  }

  Widget _bottomSheetAciklama(bool basariliMi) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        basariliMi
            ? 'Biletin haz??r. Biletlerim sekmesinden kontrol edebilirsin ;)'
            : 'Maalesef etkinli??in s??resi ge??mi??. Ba??ka etkinliklere bir g??z atsan?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Color(0xff252745).withOpacity(0.7),
        ),
      ),
    );
  }

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

  Widget _baslikVeKalp() {
    return Text(
      widget.etkinlikData!.baslik.toString(),
      overflow: TextOverflow.clip,
      style: TextStyle(
          color: Color(0xff252745),
          fontSize: 27,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w800),
    );
  }

  String _guneCevir() {
    String gunTR = '';
    final List<String> aylar = [
      "Ocak",
      "??ubat",
      "Mart",
      "Nisan",
      "May??s",
      "Haziran",
      "Temmuz",
      "A??ustos",
      "Eyl??l",
      "Ekim",
      "Kas??m",
      "Aral??k"
    ];
    var tarihFull = widget.etkinlikData!.tarih;
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
      gunTR = 'Pazartesi';
    } else if (updatedDt == 'Tuesday') {
      gunTR = 'Sal??';
    } else if (updatedDt == 'Wednesday') {
      gunTR = '??ar??amba';
    } else if (updatedDt == 'Thursday') {
      gunTR = 'Per??embe';
    } else if (updatedDt == 'Friday') {
      gunTR = 'Cuma';
    } else if (updatedDt == 'Saturday') {
      gunTR = 'Cumartesi';
    } else if (updatedDt == 'Sunday') {
      gunTR = 'Pazar';
    }
    return gunTR +
        ', ' +
        gun.toString() +
        ' ' +
        aylar[ay - 1] +
        ' ' +
        yil.toString();
  }

  Widget _etkinlikZaman() {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffe0dffa),
            ),
            height: 37,
            width: 37,
            child: Icon(
              FontAwesomeIcons.solidCalendar,
              size: 20,
              color: Theme.of(context).primaryColor,
            )),
        boslukWidth(context, 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _guneCevir(),
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
            Text(
              widget.etkinlikData!.saat.toString(),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Expanded(
            child: SizedBox(
          height: 0,
        )),
        InkWell(
            onTap: _begeniBtn,
            child: _begenildiMi
                ? Lottie.asset('assets/lottie/like.json',
                    repeat: false,
                    height: MediaQuery.of(context).size.height * 0.06)
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 15),
                    child: Icon(
                      Icons.favorite_outline,
                      size: MediaQuery.of(context).size.height * 0.03,
                      color: Color(0xffEF2E5B),
                    ),
                  ))
      ],
    );
  }

  _begeniBtn() async {
    if (_begenildiMi) {
      try {
        setState(() {
          _begenildiMi = false;
        });
        FirestoreServisi().begeniKaldir(
            aktifKullaniciId: widget.aktifKullaniciId,
            etkinlikId: widget.etkinlikData!.id);
      } catch (hata) {
        print("hata");
        print(hata.hashCode);
        print(hata);
      }
    } else {
      try {
        setState(() {
          _begenildiMi = true;
        });
        FirestoreServisi().begeniOlustur(
            aktifKullaniciId: widget.aktifKullaniciId,
            etkinlikId: widget.etkinlikData!.id);
        FirestoreServisi().populerlikSayisiArtir(widget.etkinlikData!.id);
      } catch (hata) {
        print("hata");
        print(hata.hashCode);
        print(hata);
      }
    }
  }

  Widget _etkinlikFiyat() {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffe0dffa),
            ),
            height: 37,
            width: 37,
            child: Icon(
              FontAwesomeIcons.tag,
              size: 20,
              color: Theme.of(context).primaryColor,
            )),
        boslukWidth(context, 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.etkinlikData!.ucret.toString(),
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  Widget _etkinlikSertifika() {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffe0dffa),
            ),
            height: 37,
            width: 37,
            child: Icon(
              FontAwesomeIcons.clipboardCheck,
              size: 20,
              color: Theme.of(context).primaryColor,
            )),
        boslukWidth(context, 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.etkinlikData!.sertifika.toString(),
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  Widget _etkinlikKontenjan() {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffe0dffa),
            ),
            height: 37,
            width: 37,
            child: Icon(
              FontAwesomeIcons.idCardAlt,
              size: 20,
              color: Theme.of(context).primaryColor,
            )),
        boslukWidth(context, 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.etkinlikData!.kontenjan.toString(),
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  Widget get _aciklamaBaslik => Text(
        "A????klama",
        style: TextStyle(
            color: Color(0xff252745),
            fontSize: 27,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800),
      );

  Widget get _aciklamaText => Text(
        widget.etkinlikData!.aciklama.toString(),
        style: TextStyle(
            color: Color(0xff252745),
            fontSize: 20,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400),
      );
}
