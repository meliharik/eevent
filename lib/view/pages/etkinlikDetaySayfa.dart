import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EtkinlikDetaySayfa extends StatefulWidget {
  final String baslik;
  final String foto;
  const EtkinlikDetaySayfa(
      {Key? key, this.baslik = 'null', this.foto = 'resimYok'})
      : super(key: key);

  @override
  _EtkinlikDetaySayfaState createState() => _EtkinlikDetaySayfaState();
}

class _EtkinlikDetaySayfaState extends State<EtkinlikDetaySayfa> {
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
                      background: Image.asset(
                        "assets/images/${widget.foto}.png",
                        //fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boslukHeight(context, 0.03),
                      _baslikVeKalp(widget.baslik),
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
            ),
          ),
        ));
  }

  Widget get _yeriniAyirtBtn => InkWell(
        onTap: () {
          //TODO: snackbar çıkıp biletler bölümüne eklenecek
          print("yer ayırtılacak");
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text('Yerini ayırt',
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 25,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600))),
        ),
      );

  Widget _baslikVeKalp(String? baslik) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "$baslik",
        style: TextStyle(
            color: Color(0xff252745),
            fontSize: 27,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800),
      ),
      Icon(
        FontAwesomeIcons.heart,
        size: 35,
        color: Theme.of(context).primaryColor,
      )
    ]);
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
              'Pazar, 29 Mayıs 2021',
              style: TextStyle(
                  color: Color(0xff252745),
                  fontSize: 20,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '10:00 - 13:00',
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
              'Ücretsiz',
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
              'Sertifika yok',
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
              'Kontenjan yok',
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
        "Eiusmod magna irure mollit nisi quis dolore tempor elit. Eu cupidatat excepteur ut quis amet cillum labore sunt eiusmod magna sit incididunt labore ad. Fugiat pariatur commodo magna sit reprehenderit esse ipsum proident ea consectetur eu in commodo labore. Ipsum commodo aliquip minim ea officia sit irure id proident sit fugiat nulla commodo nostrud. Magna id do veniam elit est commodo amet labore pariatur. Ut sint deserunt exercitation magna anim dolor id. Do incididunt consequat eu sit duis do Lorem anim.",
        style: TextStyle(
            color: Color(0xff252745),
            fontSize: 20,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400),
      );
}
