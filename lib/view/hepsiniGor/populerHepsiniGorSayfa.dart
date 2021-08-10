import 'package:event_app/model/etkinlik.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class PopulerHepsiniGorSayfa extends StatefulWidget {
  final String? aktifKullaniciId;
  const PopulerHepsiniGorSayfa({Key? key, this.aktifKullaniciId})
      : super(key: key);

  @override
  _PopulerHepsiniGorSayfaState createState() => _PopulerHepsiniGorSayfaState();
}

class _PopulerHepsiniGorSayfaState extends State<PopulerHepsiniGorSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Popüler Etkinlikler',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
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
        body: Column(
          children: [
            boslukHeight(context, 0.01),
            _etkinlikler,
            boslukHeight(context, 0.01)
          ],
        ));
  }

  Widget get _etkinlikler => Expanded(
        child: FutureBuilder<List<Etkinlik>>(
          future: FirestoreServisi().populerEtkinlikleriGetir(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingBouncingGrid.square(
                                      duration: Duration(milliseconds: 750),
                                      size: MediaQuery.of(context).size.height *
                                          0.05,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
              );
            }
            if (snapshot.data!.length == 0) {
              Text('Popüler olan etkinlik hiç yok :(');
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Etkinlik etkinlik = snapshot.data![index];
                return buildCard(etkinlik);
              },
            );
          },
        ),
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

  buildCard(Etkinlik etkinlik) {
    return InkWell(
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
                      loadingBuilder: (context, child, loadingProgress) {
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
                                    color: Color(0xff252745),
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
                                    color: Color(0xff252745),
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
}
