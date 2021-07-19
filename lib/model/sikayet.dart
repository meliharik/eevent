import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sikayet {
  final String? id;
  final String? sikayetEdenId;
  final String? sikayetEdeninAdiSoyadi;
  final String? sikayetEdeninMaili;
  final String? sikayetMetni;
  final String? sikayetEdeninTelefonu;

  Sikayet({
    @required this.id,
    this.sikayetEdenId,
    this.sikayetEdeninAdiSoyadi,
    this.sikayetEdeninMaili,
    this.sikayetMetni,
    this.sikayetEdeninTelefonu,
  });

  factory Sikayet.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return Sikayet(
      id: doc.id,
      sikayetEdenId: (docData as Map)['sikayetEdenId'],
      sikayetEdeninAdiSoyadi: docData['sikayetEdeninAdiSoyadi'],
      sikayetEdeninMaili: docData['sikayetEdeninMaili'],
      sikayetMetni: docData['sikayetMetni'],
      sikayetEdeninTelefonu: docData['sikayetEdeninTelefonu'],
    );
  }
}
