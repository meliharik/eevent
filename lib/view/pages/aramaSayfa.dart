import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AramaSayfa extends StatefulWidget {
  const AramaSayfa({Key? key}) : super(key: key);

  @override
  _AramaSayfaState createState() => _AramaSayfaState();
}

class _AramaSayfaState extends State<AramaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: Burası hata veriyor
      //appBar: _appBar,
      body: Center(
        child: Text('arama sayfası'),
      ),
    );
  }

  Widget get _appBar => AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            print("arama sayfasına geçecek");
          },
          icon: Icon(
            FontAwesomeIcons.slidersH,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
      title: InkWell(
        onTap: () {
          print("arama sayfasına geçecek");
        },
        child: Text(
          'Etkinlik ara...',
          style: TextStyle(
              color: Color(0xffc1b9d5),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          print("arama sayfasına geçecek");
        },
        icon: Icon(
          FontAwesomeIcons.search,
          color: Theme.of(context).primaryColor,
        ),
      ));
}
