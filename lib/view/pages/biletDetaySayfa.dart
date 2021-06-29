import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BiletDetaySayfa extends StatefulWidget {
  final String baslik;
  final String foto;
  const BiletDetaySayfa(
      {Key? key, this.baslik = 'null', this.foto = 'resimYok'})
      : super(key: key);

  @override
  State<BiletDetaySayfa> createState() => _BiletDetaySayfaState();
}

class _BiletDetaySayfaState extends State<BiletDetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text(
          'Biletim',
          style: TextStyle(
              color: Color(0xff252745),
              fontSize: 25,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
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
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 100,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
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
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Material(
          borderRadius: BorderRadius.circular(30),
          elevation: 10,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                _fotoAlani,
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boslukHeight(context, 0.01),
                          _baslikTxt(widget.baslik),
                          boslukHeight(context, 0.02),
                          _tarihSaatRow(context),
                          boslukHeight(context, 0.02),
                          _linkTxt,
                          boslukHeight(context, 0.02),
                          _qrCode(widget.baslik),
                          boslukHeight(context, 0.01),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget get _fotoAlani =>
      Expanded(flex: 4, child: Image.asset('assets/images/${widget.foto}.png'));

  Widget _baslikTxt(String baslik) {
    return Text(
      '$baslik',
      style: TextStyle(
          color: Color(0xff252745),
          fontSize: MediaQuery.of(context).size.height * 0.03,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w800),
    );
  }

  Widget _tarihSaatRow(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tarih',
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400),
            ),
            boslukHeight(context, 0.006),
            Text(
              'Cuma, 8 Temmuz 2019',
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
                  color: Color(0xff252745),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400),
            ),
            boslukHeight(context, 0.006),
            Text(
              '10:30 - 15:30',
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

  Widget get _linkTxt => Align(
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
                  launch(
                      'https://www.google.com/webhp?hl=en&ictx=2&sa=X&ved=0ahUKEwiqpvPA5abxAhV_h_0HHVslAYEQPQgJ');
                })
        ])),
      );

  Widget _qrCode(String baslik) {
    String customURL =
        'https://qrcode.tec-it.com/API/QRCode?data=${widget.baslik}%0a&backcolor=%23ffffff';
    return Expanded(
      child: Center(
          child: FutureBuilder(
        future: http.get(Uri.parse(customURL)),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('nedir bu');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return Image.memory(snapshot.data!.bodyBytes);
          }
        },
      )

          // Image.network(
          //   'https://qrcode.tec-it.com/API/QRCode?data=${widget.baslik}%0a&backcolor=%23ffffff',
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
          ),
    );
  }
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
