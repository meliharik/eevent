import 'dart:io';
import 'package:event_app/model/kullanici.dart';
import 'package:event_app/servisler/firestoreServisi.dart';
import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfiliDuzenleSayfa extends StatefulWidget {
  final Kullanici profilSahibiId;

  const ProfiliDuzenleSayfa({Key? key, required this.profilSahibiId})
      : super(key: key);

  @override
  _ProfiliDuzenleSayfaState createState() => _ProfiliDuzenleSayfaState();
}

class _ProfiliDuzenleSayfaState extends State<ProfiliDuzenleSayfa> {
  var _formKey = GlobalKey<FormState>();
  String? _adSoyad;
  File? _secilmisFoto;
  bool _yukleniyor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Profili Düzenle',
            style: TextStyle(
                color: Color(0xff252745),
                fontSize: 20,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800),
          ),
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
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                child: IconButton(
                  onPressed: () {
                    // profili düzenle onay btn
                  },
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
            boslukWidth(context, 0.035)
          ],
        ),
        body: Stack(
          children: [
            _sayfaElemanlari(),
            _yuklemeAnimasyonu(),
          ],
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

  // Widget get _profilFoto => Padding(
  //       padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
  //       child: Center(
  //         child: InkWell(
  //           onTap: _galeridenSec,
  //           child: CircleAvatar(
  //             backgroundColor: Colors.grey,
  //             backgroundImage: _secilmisFoto == null
  //                 ? NetworkImage(widget.profilSahibiId!.fotoUrl.toString())
  //                 : FileImage(_secilmisFoto as File) as ImageProvider,
  //             radius: 55.0,
  //           ),
  //         ),
  //       ),
  //     );

  // _galeridenSec() async {
  //   var image = await ImagePicker().getImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 800,
  //       maxHeight: 600,
  //       imageQuality: 80);
  //   setState(() {
  //     _secilmisFoto = File(image!.path);
  //   });
  // }

  Widget _sayfaElemanlari() {
    return Column(
      children: [
        boslukHeight(context, 0.1),
        //_profilFoto,
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              autocorrect: true,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                color: Color(0xff252745),
              ),
              initialValue: widget.profilSahibiId.adSoyad,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                hintText: 'Email',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  color: Color(0xff252745),
                ),
                errorStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  color: Color(0xffEF2E5B),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xffEF2E5B), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              validator: (input) {
                if (input!.isEmpty) {
                  return 'İsim alanı boş bırakılamaz!';
                } else if (input.trim().length <= 3) {
                  return 'Ad Soyad en az 4 karakter olmalı!';
                } else if (input.contains('@') ||
                    input.contains('.') ||
                    input.contains(',')) {
                  return 'Lütfen noktalama işaretleri kullanmayın.';
                }
                return null;
              },
              onSaved: (girilenDeger) {
                _adSoyad = girilenDeger;
              },
            ),
          ),
        )
      ],
    );
  }

  // Widget _fotoVeIsim(BuildContext context, Kullanici? profilData) {
  //   return Row(
  //     children: [
  //       boslukWidth(context, 0.04),
  //       CircleAvatar(
  //         backgroundColor: Theme.of(context).primaryColor,
  //         backgroundImage: profilData!.fotoUrl!.isNotEmpty
  //             ? NetworkImage(profilData.fotoUrl.toString())
  //             : AssetImage("assets/images/default_profile.png")
  //                 as ImageProvider,
  //         radius: MediaQuery.of(context).size.height * 0.06,
  //       ),
  //       boslukWidth(context, 0.04),
  //       Flexible(
  //         child: Text(
  //           profilData.adSoyad.toString(),
  //           style: TextStyle(
  //               color: Color(0xff252745),
  //               fontSize: MediaQuery.of(context).size.height * 0.023,
  //               fontFamily: 'Manrope',
  //               fontWeight: FontWeight.w800),
  //         ),
  //       ),
  //       boslukHeight(context, 0.02)
  //     ],
  //   );
  // }
}
