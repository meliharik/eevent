import 'dart:io';
import 'package:eevent/model/kullanici.dart';
import 'package:eevent/servisler/firestoreServisi.dart';
import 'package:eevent/servisler/storageServisi.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';

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
                    _kaydet();
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
            _yuklemeAnimasyonu(),
            _sayfaElemanlari(),
          ],
        ));
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

  Widget _sayfaElemanlari() {
    return SingleChildScrollView(
      child: Column(
        children: [
          boslukHeight(context, 0.04),
          _profilFoto,
          _fotoyuDegistirText,
          boslukHeight(context, 0.04),
          _adSoyadTextField,
          boslukHeight(context, 0.03),
          _emailTextField,
          boslukHeight(context, 0.005),
          _emailDegismezText,
        ],
      ),
    );
  }

  _kaydet() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _yukleniyor = true;
      });

      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      String profilFotoUrl;
      if (_secilmisFoto == null) {
        profilFotoUrl = widget.profilSahibiId.fotoUrl!;
      } else {
        profilFotoUrl = await StorageServisi().profilResmiYukle(_secilmisFoto!);
      }

      FirestoreServisi().kullaniciGuncelle(
          kullaniciId: widget.profilSahibiId.id,
          adSoyad: _adSoyad,
          fotoUrl: profilFotoUrl);

      setState(() {
        _yukleniyor = false;
      });

      Navigator.pop(context);
    }
  }

  Widget get _profilFoto => Center(
        child: InkWell(
          onTap: _galeridenSec,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: _fotoGetir(),
            radius: 75.0,
          ),
        ),
      );

  _fotoGetir() {
    if (_secilmisFoto == null) {
      if (widget.profilSahibiId.fotoUrl!.isEmpty) {
        return AssetImage("assets/images/default_profile.png");
      } else {
        return NetworkImage(widget.profilSahibiId.fotoUrl.toString());
      }
    } else {
      return FileImage(_secilmisFoto!);
    }
  }

  _galeridenSec() async {
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      _secilmisFoto = File(image!.path);
    });
  }

  Widget get _fotoyuDegistirText => TextButton(
      onPressed: _galeridenSec,
      child: Text(
        'Profil Fotoğrafını Değiştir',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Color(0xff252745),
        ),
      ));

  Widget get _adSoyadTextField => Form(
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
              prefixIcon: Icon(
                FontAwesomeIcons.userAlt,
                color: Theme.of(context).primaryColor,
              ),
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(),
              hintText: 'Ad Soyad',
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
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 2),
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
      );

  Widget get _emailTextField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          enableInteractiveSelection: false,
          readOnly: true,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            color: Color(0xff252745),
          ),
          initialValue: widget.profilSahibiId.email,
          decoration: InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: Theme.of(context).primaryColor,
            ),
            contentPadding: EdgeInsets.all(15),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ),
      );

  Widget get _emailDegismezText => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Email değiştirme işlemi şu anlık aktif değil, üzerinde çalışıyoruz :/',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xffEF2E5B),
          ),
        ),
      );
}
