import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Etkinlik {
  final String? id;
  final String? etkinlikResmiUrl;
  final String? baslik;
  final String? aciklama;
  final String? kategori;
  final String? tarih;
  final String? saat;
  final String? sertifika;
  final String? ucret;
  final String? kontenjan;
  final int? populerlikSayisi;
  final String? meetingId;
  final String? meetingPass;
  final String? meetingLink;

  Etkinlik({
    @required this.id,
    this.etkinlikResmiUrl,
    this.baslik,
    this.aciklama,
    this.kategori,
    this.tarih,
    this.saat,
    this.sertifika,
    this.ucret,
    this.kontenjan,
    this.populerlikSayisi,
    this.meetingId,
    this.meetingPass,
    this.meetingLink,
  });

  factory Etkinlik.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return Etkinlik(
      id: doc.id,
      etkinlikResmiUrl: (docData as Map)['foto'],
      baslik: docData['baslik'],
      aciklama: docData['aciklama'],
      kategori: docData['kategori'],
      tarih: docData['tarih'],
      saat: docData['saat'],
      sertifika: docData['sertifika'],
      ucret: docData['ucret'],
      kontenjan: docData['kontenjan'],
      populerlikSayisi: docData['populerlikSayisi'],
      meetingId: docData['meetingId'],
      meetingPass: docData['meetingPass'],
      meetingLink: docData['meetingLink'],
    );
  }
}
