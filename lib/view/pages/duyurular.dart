import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DuyurularSayfa extends StatefulWidget {
  const DuyurularSayfa({Key? key}) : super(key: key);

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
    );
  }
}
