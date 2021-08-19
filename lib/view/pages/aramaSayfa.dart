import 'package:eevent/model/etkinlik.dart';
import 'package:eevent/servisler/firestoreServisi.dart';
import 'package:eevent/view/pages/etkinlikDetaySayfa.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lottie/lottie.dart';

class AramaSayfa extends StatefulWidget {
  final String? aktifKullaniciId;

  const AramaSayfa({Key? key, this.aktifKullaniciId}) : super(key: key);

  @override
  _AramaSayfaState createState() => _AramaSayfaState();
}

class _AramaSayfaState extends State<AramaSayfa> {
  final aramaController = TextEditingController();
  Future<List<Etkinlik>>? _aramaSonucu;
  ValueNotifier<bool> notifier = ValueNotifier(false);
  List secilenler = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sayfaElemanlari,
    );
  }

  Widget get _sayfaElemanlari => SafeArea(
        child: Column(
          children: [
            boslukHeight(context, 0.02),
            _aramaTextField(),
            boslukHeight(context, 0.01),
            _kategoriContainer,
            _aramaSonucu != null ? sonuclariGetir() : aramaYok()
          ],
        ),
      );

  _aramaTextField() {
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (_, notif, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          onFieldSubmitted: (girilenDeger) {
            setState(() {
              _aramaSonucu = FirestoreServisi().etkinlikAra(girilenDeger);
            });
          },
          onChanged: (value) {
            value.length > 0 ? notifier.value = true : notifier.value = false;
          },
          controller: aramaController,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            color: Color(0xff252745),
          ),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(color: Theme.of(context).unselectedWidgetColor),
              ),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              hintText: 'Etkinlik Ara',
              hintStyle: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                color: Color(0xff252745).withOpacity(0.6),
              ),
              suffixIcon: notif
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        aramaController.clear();
                        setState(() {
                          _aramaSonucu = null;
                        });
                      },
                    )
                  : null,
              prefixIcon: Icon(FontAwesomeIcons.search)),
        ),
      ),
    );
  }

  Widget get _kategoriContainer => Card(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ExpansionTile(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Kategori',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: MediaQuery.of(context).size.height * 0.035,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
          children: [
            Wrap(
              children: [
                _buildChip('Yazılım'),
                _buildChip('Sağlık'),
                _buildChip('Finans'),
                _buildChip('Psikoloji'),
                _buildChip('Eğitim'),
                _buildChip('Tarih'),
                _buildChip('Gelecek'),
                _buildChip('Sosyoloji'),
                _buildChip('Girişimcilik'),
                _buildChip('Teknoloji'),
                _buildChip('Sanat'),
                _buildChip('Bilim'),
                _buildChip('Tasarım'),
                _buildChip('Kariyer'),
              ],
            )
          ],
        ),
      );

  aramaYok() {
    return Center(child: Text(""));
    //TODO: hemen etkinlik ara gibi bir text girilebilir
  }

  Widget _buildChip(String label) {
    bool _selected = false;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8),
      child: ChoiceChip(
        selected: secilenler.contains(label),
        selectedColor: Theme.of(context).primaryColorLight,
        onSelected: (bool selected) {
          setState(() {
            _selected = !_selected;
            if (selected) {
              if (secilenler.length == 0) {
                secilenler.add(label);
              } else {
                secilenler.clear();
                secilenler.add(label);
              }
            } else {
              secilenler.clear();

              _aramaSonucu = null;
            }
          });

          _aramaSonucu = FirestoreServisi().kategoriyeGoreArama(secilenler[0]);
        },
        labelPadding: EdgeInsets.all(5),
        label: Text(
          label,
          style: TextStyle(
              color: _selected
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).primaryColor,
              fontSize: MediaQuery.of(context).size.height * 0.022,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800),
        ),
        shape: StadiumBorder(
            side: BorderSide(
                color: _selected
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).primaryColor)),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        labelStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: MediaQuery.of(context).size.height * 0.022,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800),
      ),
    );
  }

  sonuclariGetir() {
    return Expanded(
      child: FutureBuilder<List<Etkinlik>>(
          future: _aramaSonucu,
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/cant_find.json',
                        height: MediaQuery.of(context).size.height * 0.15),
                    boslukHeight(context, 0.05),
                    Text(
                      "Girilen değere uygun etkinlik bulamadık :(",
                      style: TextStyle(
                          color: Color(0xff252745),
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Etkinlik etkinlik = snapshot.data![index];
                  return buildCard(etkinlik);
                });
          }),
    );
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                          child: Image.network(
                        etkinlik.etkinlikResmiUrl.toString(),
                        fit: BoxFit.fill,
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
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
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
      ),
    );
  }
}
