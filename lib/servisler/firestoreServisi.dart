import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/model/kullanici.dart';

class FirestoreServisi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime zaman = DateTime.now();

  Future<void> kullaniciOlustur(
      {id, email, adSoyad, fotoUrl = "", dogrulandiMi = "false"}) async {
    await _firestore.collection("kullanicilar").doc(id).set({
      "id": id,
      "adSoyad": adSoyad,
      "email": email,
      "fotoUrl": fotoUrl,
      "olusturulmaZamani": zaman,
      "dogrulandiMi": dogrulandiMi
    });
  }

  Future<Kullanici?> kullaniciGetir(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("kullanicilar").doc(id).get();
    if (doc.exists) {
      Kullanici kullanici = Kullanici.dokumandanUret(doc);
      return kullanici;
    }
  }
}
