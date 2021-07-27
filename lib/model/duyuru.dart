import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Duyuru {
  final String? id;
  final String? kullaniciId;
  final String? etkinlikId;
  final String? etkinlikFoto;
  final String? etkinlikAdi;
  final String? duyuruTipi;
  final String? sikayetId;
  final String? gorulduMu;
  final Timestamp? olusturulmaZamani;

  Duyuru({
    @required this.id,
    this.kullaniciId,
    this.etkinlikId,
    this.etkinlikFoto,
    this.etkinlikAdi,
    this.duyuruTipi,
    this.olusturulmaZamani,
    this.gorulduMu,
    this.sikayetId,
  });

  factory Duyuru.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return Duyuru(
      id: doc.id,
      kullaniciId: (docData as Map)['kullaniciId'],
      etkinlikId: docData['etkinlikId'],
      etkinlikFoto: docData['etkinlikFoto'],
      etkinlikAdi: docData['etkinlikAdi'],
      duyuruTipi: docData['duyuruTipi'],
      gorulduMu: docData['gorulduMu'],
      olusturulmaZamani: docData['olusturulmaZamani'],
      sikayetId: docData['sikayetId'],
    );
  }
}
