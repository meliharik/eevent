import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Kullanici {
  final String? id;
  final String? adSoyad;
  final String? fotoUrl;
  final String? email;
  final String? dogrulandiMi;

  Kullanici(
      {@required this.id,
      this.adSoyad,
      this.fotoUrl,
      this.email,
      this.dogrulandiMi});

  factory Kullanici.firebasedenUret(User kullanici) {
    return Kullanici(
      id: kullanici.uid,
      adSoyad: kullanici.displayName,
      fotoUrl: kullanici.photoURL,
      email: kullanici.email,
    );
  }

  factory Kullanici.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return Kullanici(
        id: doc.id,
        adSoyad: (docData as Map)['adSoyad'],
        email: docData['email'],
        fotoUrl: docData['fotoUrl'],
        dogrulandiMi: docData['dogrulandiMi']);
  }
}
