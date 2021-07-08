import 'package:event_app/model/etkinlik.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/servisler/yetkilendirmeServisi.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

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
  bool _yukleniyor = false;

  _biletKontrol() async {
    bool biletVarMi = await FirestoreServisi().biletVarMi(
        aktifKullaniciId: widget.aktifKullaniciId,
        etkinlikId: widget.etkinlikData!.id);
    setState(() {
      _biletVarMi = biletVarMi;
    });
  }

  @override
  void initState() {
    super.initState();
    _biletKontrol();
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
                      padding: const EdgeInsets.only(left: 8.0),
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
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: 100,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text("Paylaş"),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text("Şikayet Et"),
                                value: 2,
                              )
                            ],
                            onSelected: (int menu) {
                              if (menu == 1) {
                                //TODO: paylaşma metni girilecek
                              } else if (menu == 2) {
                                //TODO: şikayet sayfasına gidecek
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
                    floating: true,
                    snap: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Image.network(
                          widget.etkinlikData!.etkinlikResmiUrl.toString(),
                          //fit: BoxFit.cover,
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

  Widget _yuklemeAnimasyonu() {
    if (_yukleniyor) {
      return Center(
        child: CircularProgressIndicator(),
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
                // TODO: tüm etkinlikler online olacağı için iptal edildi
                //_etkinlikYer(),
                //boslukHeight(context, 0.02),
                _etkinlikFiyat(),
                boslukHeight(context, 0.02),
                _etkinlikSertifika(),
                boslukHeight(context, 0.02),
                _etkinlikKontenjan(),
                boslukHeight(context, 0.02),
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
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(_biletVarMi ? 'Biletin Hazır' : 'Yerini Ayırt',
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 25,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600))),
        ),
      );

  biletAlma() async {
    setState(() {
      _yukleniyor = true;
    });
    try {
      FirestoreServisi().biletOlustur(
          aktifKullaniciId: widget.aktifKullaniciId,
          etkinlikId: widget.etkinlikData!.id);
      setState(() {
        _yukleniyor = false;
        _biletVarMi = true;
      });

      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          context: context,
          builder: (context) {
            return Column(
              children: [
                Lottie.asset('assets/lottie/time.json',
                    height: MediaQuery.of(context).size.height * 0.25),
                _bottomSheetBasarili,
                _bottomSheetAciklama,
                boslukHeight(context, 0.04),
                _tamamBtn,
              ],
            );
          });
    } catch (hata) {
      setState(() {
        _yukleniyor = false;
      });
      print("hata: " + hata.toString() + hata.hashCode.toString());
      var snackBar = SnackBar(content: Text('Bir hata oluştu'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        'Biletin hazır. Biletlerim sekmesinden kontrol edebilirsin ;)',
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
      gunTR = 'Salı';
    } else if (updatedDt == 'Wednesday') {
      gunTR = 'Çarşamba';
    } else if (updatedDt == 'Thursday') {
      gunTR = 'Perşembe';
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
              style:
                  TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
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
        "Açıklama",
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
