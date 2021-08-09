import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/model/duyuru.dart';
import 'package:event_app/model/etkinlik.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/view/pages/biletDetaySayfa.dart';
import 'package:event_app/view/pages/etkinlikDetaySayfa.dart';
import 'package:event_app/view/pages/sikayetDetaySayfa.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DuyurularSayfa extends StatefulWidget {
  final String? aktifKullaniciId;

  const DuyurularSayfa({Key? key, this.aktifKullaniciId}) : super(key: key);

  @override
  _DuyurularSayfaState createState() => _DuyurularSayfaState();
}

class _DuyurularSayfaState extends State<DuyurularSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text(
          'Duyuruların',
          style: TextStyle(
              color: Color(0xff252745),
              fontSize: MediaQuery.of(context).size.height * 0.03,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800),
        ),
        elevation: 0,
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
      body: Column(
        children: [
          boslukHeight(context, 0.01),
          _duyurular,
          boslukHeight(context, 0.01)
        ],
      ),
    );
  }

  Widget get _duyurular => Expanded(
        child: FutureBuilder<List<Duyuru>>(
          future: FirestoreServisi()
              .duyurulariGetir(profilSahibiId: widget.aktifKullaniciId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.length == 0) {
              Text('Hiç duyurun yok.');
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Duyuru duyuru = snapshot.data![index];
                return buildCard(duyuru);
              },
            );
          },
        ),
      );

  sikayeteGoreNavigator(Duyuru duyuru) async {
    if (duyuru.duyuruTipi == 'azKaldi') {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("etkinlikler")
          .doc(duyuru.id)
          .get();
      if (doc.exists) {
        Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
        var now = new DateTime.now();

        DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
            .parse(etkinlik.tarih.toString() + ' ' + etkinlik.saat.toString());
        if (etkinlikZamani.hour == 00) {
          etkinlikZamani = DateTime(etkinlikZamani.year, etkinlikZamani.month,
              etkinlikZamani.day, 12);
        }
        if (etkinlikZamani.isAfter(now)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BiletDetaySayfa(
                        aktifKullaniciId: widget.aktifKullaniciId,
                        etkinlikData: etkinlik,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EtkinlikDetaySayfa(
                        aktifKullaniciId: widget.aktifKullaniciId,
                        etkinlikData: etkinlik,
                      )));
        }
      }
    } else if (duyuru.duyuruTipi == 'sikayet') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SikayetDetaySayfa(
                    aktfifKullaniciId: widget.aktifKullaniciId,
                    sikayetId: duyuru.id,
                  )));
    }
  }

  sikayeteGoreText(Duyuru duyuru) {
    if (duyuru.duyuruTipi == 'azKaldi') {
      return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: duyuru.etkinlikAdi,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600)),
          TextSpan(
              text:
                  ' başlıklı etkinlik 30 dakika içinde başlayacak! Hazır mısın?',
              style: TextStyle(
                  color: Color(0xff252745),
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400)),
        ]),
      );
    } else {
      return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: duyuru.sikayetId,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600)),
          TextSpan(
              text: ' kimlikli şikayetini değerlendirdik.',
              style: TextStyle(
                  color: Color(0xff252745),
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400)),
        ]),
      );
    }
  }

  buildCard(Duyuru duyuru) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            sikayeteGoreNavigator(duyuru);
          },
          child: Card(
            child: ListTile(
              leading: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: duyuru.duyuruTipi == 'azKaldi'
                    ? Image.asset("assets/images/time.png")
                    : Image.asset("assets/images/report.png"),
              ),
              // title: duyuru.duyuruTipi == 'azKaldi'
              //     ? Text(
              //         '30 dakika kaldı!',
              //         style: TextStyle(
              //             color: Color(0xff252745),
              //             fontFamily: 'Manrope',
              //             fontWeight: FontWeight.w600),
              //       )
              //     : Text(
              //         'Şikayetin Değerlendirildi!',
              //         style: TextStyle(
              //             color: Color(0xff252745),
              //             fontFamily: 'Manrope',
              //             fontWeight: FontWeight.w600),
              //       ),
              isThreeLine: true,
              subtitle: Column(
                children: [
                  sikayeteGoreText(duyuru),
                  Row(
                    children: [
                      Text(
                        timeago.format(duyuru.olusturulmaZamani!.toDate(),
                            locale: "tr"),
                      ),
                    ],
                  )
                ],
              ),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: duyuru.duyuruTipi == 'azKaldi'
                    ? Image.network(
                        duyuru.etkinlikFoto.toString(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ),
            ),
          ),
        ),
        boslukHeight(context, 0.01)
      ],
    );
  }

  // buildCard(Duyuru duyuru) {
  //   return InkWell(
  //     onTap: () {
  //       print('deneme');
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: Card(
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(16),
  //           child: Row(
  //             children: [
  //               Container(
  //                   width: MediaQuery.of(context).size.width * 0.3,
  //                   height: MediaQuery.of(context).size.height * 0.15,
  //                   child: Center(
  //                       child: Image.network(
  //                     duyuru.etkinlikFoto.toString(),
  //                     fit: BoxFit.fill,
  //                   ))),
  //               boslukWidth(context, 0.02),
  //               Expanded(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       duyuru.etkinlikAdi.toString(),
  //                       overflow: TextOverflow.clip,
  //                       style: TextStyle(
  //                           color: Color(0xff252745),
  //                           fontSize: MediaQuery.of(context).size.height * 0.02,
  //                           fontFamily: 'Manrope',
  //                           fontWeight: FontWeight.w800),
  //                     ),
  //                     boslukHeight(context, 0.006),
  //                     Row(
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Tarih',
  //                               style: TextStyle(
  //                                   color: Color(0xff252745),
  //                                   fontSize:
  //                                       MediaQuery.of(context).size.height *
  //                                           0.018,
  //                                   fontFamily: 'Manrope',
  //                                   fontWeight: FontWeight.w400),
  //                             ),
  //                             boslukHeight(context, 0.006),
  //                             Text(
  //                               'örnek tarih',
  //                               style: TextStyle(
  //                                   color: Color(0xff252745),
  //                                   fontSize:
  //                                       MediaQuery.of(context).size.height *
  //                                           0.018,
  //                                   fontFamily: 'Manrope',
  //                                   fontWeight: FontWeight.w600),
  //                             )
  //                           ],
  //                         ),
  //                         Expanded(
  //                             child: SizedBox(
  //                           height: 0,
  //                         )),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Saat',
  //                               style: TextStyle(
  //                                   color: Color(0xff252745),
  //                                   fontSize:
  //                                       MediaQuery.of(context).size.height *
  //                                           0.018,
  //                                   fontFamily: 'Manrope',
  //                                   fontWeight: FontWeight.w400),
  //                             ),
  //                             boslukHeight(context, 0.006),
  //                             Text(
  //                               'örnek saat',
  //                               style: TextStyle(
  //                                   color: Color(0xff252745),
  //                                   fontSize:
  //                                       MediaQuery.of(context).size.height *
  //                                           0.018,
  //                                   fontFamily: 'Manrope',
  //                                   fontWeight: FontWeight.w600),
  //                             )
  //                           ],
  //                         ),
  //                         boslukWidth(context, 0.1),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
