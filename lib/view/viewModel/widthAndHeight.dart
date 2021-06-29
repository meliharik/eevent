import 'package:flutter/material.dart';

Widget boslukHeight(BuildContext context, double deger) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * deger,
  );
}

Widget boslukWidth(BuildContext context, double deger) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * deger,
  );
}
