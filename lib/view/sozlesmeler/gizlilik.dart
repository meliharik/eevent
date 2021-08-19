import 'package:eevent/model/widthAndHeight.dart';
import 'package:eevent/view/sozlesmeler/gizlilikPolitikasi.dart';
import 'package:eevent/view/sozlesmeler/kullanimKosullari.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GizlilikSayfa extends StatelessWidget {
  const GizlilikSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text(
          'Gizlilik',
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
          boslukHeight(context, 0.02),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GizlilikPolitikasiSayfa()));
            },
            child: ListTile(
              minVerticalPadding: 0,
              horizontalTitleGap: 0,
              leading: Icon(
                Icons.security,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Gizlilik Politikası',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                FontAwesomeIcons.angleRight,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => KullanimKosullariSayfa()));
            },
            child: ListTile(
              minVerticalPadding: 0,
              horizontalTitleGap: 0,
              leading: Icon(
                FontAwesomeIcons.userTie,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Kullanım Koşulları',
                style: TextStyle(
                    color: Color(0xff252745),
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                FontAwesomeIcons.angleRight,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
