import 'package:flutter/material.dart';

class InternetUyariSayfa extends StatelessWidget {
  const InternetUyariSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
          child: Container(
        child: Text('selam'),
      )),
    );
    //TODO: girişte internet kontrol edilecek
  }
}
