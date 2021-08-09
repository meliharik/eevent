import 'package:event_app/model/etkinlik.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/servisler/notificationServisi.dart';
import 'package:event_app/view/pages/sikayetEtSayfa.dart';
import 'package:event_app/view/viewModel/tabbar_view.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BiletDetaySayfa extends StatefulWidget {
  final String? aktifKullaniciId;
  final Etkinlik? etkinlikData;
  const BiletDetaySayfa({Key? key, this.aktifKullaniciId, this.etkinlikData})
      : super(key: key);

  @override
  State<BiletDetaySayfa> createState() => _BiletDetaySayfaState();
}

class _BiletDetaySayfaState extends State<BiletDetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: Text(
            'Biletim',
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                child: PopupMenuButton(
                  elevation: 5,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        "Paylaş",
                        style: TextStyle(
                            color: Color(0xff252745),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w600),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Şikayet Et",
                        style: TextStyle(
                            color: Color(0xff252745),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w600),
                      ),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Bileti sil",
                        style: TextStyle(
                            color: Color(0xffEF2E5B),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w600),
                      ),
                      value: 3,
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
                                    aktifKullaniciId: widget.aktifKullaniciId,
                                  )));
                    } else if (menu == 3) {
                      _biletiSilAlert();
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
          ],
        ),
        body: Center(child: _sayfaElemanlari)
        //     child: SingleChildScrollView(
        //   child: Material(
        //     borderRadius: BorderRadius.circular(30),
        //     elevation: 10,
        //     child: Container(
        //       height: MediaQuery.of(context).size.height * 0.8,
        //       width: MediaQuery.of(context).size.width * 0.9,
        //       child: Column(
        //         children: [
        //           _fotoAlani,
        //           Expanded(
        //               flex: 6,
        //               child: Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     boslukHeight(context, 0.01),
        //                     _baslikTxt(widget.baslik),
        //                     boslukHeight(context, 0.02),
        //                     _tarihSaatRow(context),
        //                     boslukHeight(context, 0.02),
        //                     _linkTxt,
        //                     boslukHeight(context, 0.02),
        //                     _qrCode(widget.baslik),
        //                     boslukHeight(context, 0.01),
        //                   ],
        //                 ),
        //               )),
        //         ],
        //       ),
        //     ),
        //   ),
        // )

        );
  }

  void _paylas(BuildContext context) {
    //TODO: <APP_LINK> yerine uygulamanın store linki olacak
    final String? text =
        "${widget.etkinlikData!.baslik} isimli etkinliğe bilet aldım. Sen de evde boş boş oturacağıma kendimi geliştireyim diyorsan hadi uygulamayı yükle.\nhttps://play.google.com/store/apps/details?id=app.eevent.eevent";

    Share.share(text.toString(), subject: 'Uygulamayı indir!');
  }

  Widget get _sayfaElemanlari => Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.86,
            width: MediaQuery.of(context).size.width * 0.95,
            child: FutureBuilder<Etkinlik?>(
              future: FirestoreServisi().etkinlikGetir(widget.etkinlikData!.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _fotoAlani,
                      boslukHeight(context, 0.01),
                      _baslikTxt(),
                      boslukHeight(context, 0.02),
                      _tarihSaatRow(context),
                      boslukHeight(context, 0.02),
                      _meetingIdAndPass(),
                      boslukHeight(context, 0.02),
                      _linkTxt(),
                      boslukHeight(context, 0.02),
                      _divider,
                      boslukHeight(context, 0.02),
                      _qrCode(),
                      _biletBilgileriText
                    ],
                  ),
                );
              },
            )),
      );

  _biletiSilAlert() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: new Text(
            "Dikkat!!",
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800,
              fontSize: MediaQuery.of(context).size.height * 0.03,
              color: Color(0xff252745),
            ),
          ),
          content: new Text(
            "Gerçekten biletini silmek istiyor musun?",
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * 0.022,
              color: Color(0xff252745),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: new Text(
                "Hayır",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800,
                  fontSize: MediaQuery.of(context).size.height * 0.023,
                  color: Color(0xff252745),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text(
                "Evet",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800,
                  fontSize: MediaQuery.of(context).size.height * 0.023,
                  color: Color(0xffEF2E5B),
                ),
              ),
              onPressed: _biletiSil,
            ),
          ],
        );
      },
    );
  }

  _biletiSil() async {
    try {
      FirestoreServisi().biletKaldir(
          aktifKullaniciId: widget.aktifKullaniciId,
          etkinlikId: widget.etkinlikData!.id);
      await NotificationService()
          .cancelNotification(widget.etkinlikData!.id.hashCode);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => TabBarMain(
                    aktifKullaniciId: widget.aktifKullaniciId,
                  )));
    } catch (hata) {
      var snackBar = SnackBar(content: Text('Bir hata oluştu'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("hata");
      print(hata.hashCode);
      print(hata);
    }
  }

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

  Widget get _fotoAlani => Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(
        widget.etkinlikData!.etkinlikResmiUrl.toString(),
        fit: BoxFit.fill,
      ));

  Widget _baslikTxt() {
    return Row(
      children: [
        boslukWidth(context, 0.02),
        Expanded(
          child: Text(
            widget.etkinlikData!.baslik.toString(),
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Widget _meetingIdAndPass() {
    if (widget.etkinlikData!.meetingId!.isNotEmpty) {
      return Column(
        children: [
          Row(
            children: [
              boslukWidth(context, 0.02),
              Text(
                'Etkinlik ID: ',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600),
              ),
              SelectableText(
                widget.etkinlikData!.meetingId.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
          Row(
            children: [
              boslukWidth(context, 0.02),
              Text(
                'Etkinlik Şifre: ',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600),
              ),
              SelectableText(
                widget.etkinlikData!.meetingPass.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Widget _tarihSaatRow(BuildContext context) {
    return Row(
      children: [
        boslukWidth(context, 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tarih',
              style: TextStyle(
                  color: Color(0xff252745).withOpacity(.6),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
            boslukHeight(context, 0.006),
            Text(
              _guneCevir(widget.etkinlikData as Etkinlik),
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800),
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
                  color: Color(0xff252745).withOpacity(.6),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
            boslukHeight(context, 0.006),
            Text(
              widget.etkinlikData!.saat.toString(),
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ],
    );
  }

  Widget _linkTxt() {
    if (widget.etkinlikData!.meetingLink!.isNotEmpty) {
      return Align(
        alignment: Alignment.center,
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Etkinlik linki için ',
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600)),
          TextSpan(
              text: 'tıklayın.',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xff5E4BC3),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launch(widget.etkinlikData!.meetingLink.toString());
                })
        ])),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Widget get _divider => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          300 ~/ (10 + 5),
          (_) => Container(
            width: MediaQuery.of(context).size.width / 30,
            height: 2,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 5 / 2, right: 5 / 2),
          ),
        ),
      );

  Widget _qrCode() {
    String customUrl;

    if (widget.etkinlikData!.meetingLink!.isEmpty) {
      String _customUrl = "${widget.etkinlikData!.baslik}";
      customUrl = _customUrl;
    } else {
      String _customUrl =
          "${widget.etkinlikData!.baslik}%0A${widget.etkinlikData!.tarih}%0A${widget.etkinlikData!.saat}%0A${widget.etkinlikData!.meetingId}%0A${widget.etkinlikData!.meetingPass}%0A${widget.etkinlikData!.meetingLink}";
      customUrl = _customUrl;
    }
    String url =
        'http://api.qrserver.com/v1/create-qr-code/?data=${customUrl}&size=100x100';
    return Center(
        child: FutureBuilder(
      future: http.get(Uri.parse(url)),
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('QR code bulunamadı :(');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Hata: ${snapshot.error}');
            return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.memory(
                snapshot.data!.bodyBytes,
                fit: BoxFit.cover,
              ),
            );
        }
      },
    )

        // Image.network(
        //   'https://qrcode.tec-it.com/API/QRCode?data=${widget.baslik}%0a&backcolor=%23fafafa;size=100x100',
        //   semanticLabel: 'QR Code',
        //   fit: BoxFit.fill,
        //   loadingBuilder: (context, child, loadingProgress) {
        //     if (loadingProgress == null) return child;

        //     return Center(child: Text('Loading...'));
        //     // You can use LinearProgressIndicator or CircularProgressIndicator instead
        //   },
        //   // loadingBuilder: (BuildContext context, Widget child,
        //   //     ImageChunkEvent? loadingProgress) {
        //   //   if (loadingProgress == null) {
        //   //     return child;
        //   //   }
        //   //   return Center(
        //   //     child: CircularProgressIndicator(
        //   //       value: loadingProgress.expectedTotalBytes != null
        //   //           ? loadingProgress.cumulativeBytesLoaded /
        //   //               loadingProgress.expectedTotalBytes!
        //   //           : null,
        //   //     ),
        //   //   );
        //   // },
        // ),
        );
  }

  Widget get _biletBilgileriText => Text(
        'Bilet Bilgileri',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.height * 0.02,
          color: Color(0xff252745),
        ),
      );
}

// Image.network(imgURL,fit: BoxFit.fill,
//   loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
//   if (loadingProgress == null) return child;
//     return Center(
//       child: CircularProgressIndicator(
//       value: loadingProgress.expectedTotalBytes != null ?
//              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
//              : null,
//       ),
//     );
//   },
// ),
