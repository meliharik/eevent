import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/model/etkinlik.dart';
import 'package:event_app/model/kullanici.dart';
import 'package:intl/intl.dart';

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

  void kullaniciGuncelle(
      {String? kullaniciId, String? adSoyad, String fotoUrl = ""}) {
    _firestore
        .collection("kullanicilar")
        .doc(kullaniciId)
        .update({"adSoyad": adSoyad, "fotoUrl": fotoUrl});
  }

  void dogrulamaGuncelle({String? kullaniciId, String? dogrulandiMi}) {
    _firestore
        .collection("kullanicilar")
        .doc(kullaniciId)
        .update({"dogrulandiMi": dogrulandiMi});
  }

  Future<List<Etkinlik>> etkinlikAra(String kelime) async {
    QuerySnapshot snapshot = await _firestore
        .collection("etkinlikler")
        .where(
          "baslik",
          isGreaterThanOrEqualTo: kelime.toUpperCase(),
          isLessThan: kelime.substring(0, kelime.length - 1) +
              String.fromCharCode(kelime.codeUnitAt(kelime.length - 1) + 1),
        )
        .get();
    print(snapshot);
    List<Etkinlik> etkinlikler =
        snapshot.docs.map((doc) => Etkinlik.dokumandanUret(doc)).toList();
    print(etkinlikler.length);
    return etkinlikler;

    //TODO: günü geçmiş etkinliklet listeye eklenmesin
  }

  Future<List<Etkinlik>> kategoriyeGoreArama(String kategori) async {
    QuerySnapshot snapshot = await _firestore.collection("etkinlikler").get();
    List<Etkinlik> etkinlikler = [];

    snapshot.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      var now = new DateTime.now();

      DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
          .parse(etkinlik.tarih.toString() + ' ' + etkinlik.saat.toString());

      if (etkinlikZamani.isAfter(now) && etkinlik.kategori == kategori) {
        etkinlikler.add(etkinlik);
      }
    });
    return etkinlikler;
  }

  Future<List<Etkinlik>> populerEtkinlikleriGetir(bool limit) async {
    QuerySnapshot _snapshot;
    if (limit == true) {
      QuerySnapshot snapshot = await _firestore
          .collection("etkinlikler")
          .orderBy("populerlikSayisi", descending: true)
          .limit(7)
          .get();
      _snapshot = snapshot;
    } else {
      QuerySnapshot snapshot = await _firestore
          .collection("etkinlikler")
          .orderBy("populerlikSayisi", descending: true)
          .get();
      _snapshot = snapshot;
    }
    List<Etkinlik> etkinlikler = [];
    _snapshot.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      var now = new DateTime.now();

      DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
          .parse(etkinlik.tarih.toString() + ' ' + etkinlik.saat.toString());
      if (etkinlikZamani.isAfter(now)) {
        etkinlikler.add(etkinlik);
      }
    });
    return etkinlikler;
  }

  Future<List<Etkinlik>> buHaftaEtkinlikleriGetir(bool limit) async {
    QuerySnapshot _snapshot;
    if (limit = true) {
      QuerySnapshot snapshot = await _firestore
          .collection("etkinlikler")
          .orderBy("tarih", descending: false)
          .limit(7)
          .get();
      _snapshot = snapshot;
    } else {
      QuerySnapshot snapshot = await _firestore
          .collection("etkinlikler")
          .orderBy("tarih", descending: false)
          .get();
      _snapshot = snapshot;
    }
    List<Etkinlik> etkinlikler = [];
    _snapshot.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      var now = new DateTime.now();
      int today = now.weekday;

      var dayNr = (today + 6) % 7;
      var thisMonday = now.subtract(new Duration(days: (dayNr)));
      var thisSunday = thisMonday.add(new Duration(days: 6));

      thisMonday =
          DateTime(thisMonday.year, thisMonday.month, thisMonday.day, 00, 00);
      thisSunday =
          DateTime(thisSunday.year, thisSunday.month, thisSunday.day, 23, 59);

      //TODO: 19-25 temmuz arasındaki hafta 24 temmuz etkinlikleri gözükmedi

      DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
          .parse(etkinlik.tarih.toString() + ' ' + etkinlik.saat.toString());

      if (thisMonday.isBefore(etkinlikZamani) &&
          thisSunday.isAfter(etkinlikZamani) &&
          etkinlikZamani.isAfter(now)) {
        etkinlikler.add(etkinlik);
      }
    });
    return etkinlikler;
  }

  Future<List<Etkinlik>> bugunEtkinlikleriGetir(bool limit) async {
    QuerySnapshot _snapshot;
    if (limit == true) {
      QuerySnapshot snapshot = await _firestore
          .collection("etkinlikler")
          .orderBy("saat", descending: true)
          .limit(7)
          .get();
      _snapshot = snapshot;
    } else {
      QuerySnapshot snapshot = await _firestore
          .collection("etkinlikler")
          .orderBy("saat", descending: true)
          .get();
      _snapshot = snapshot;
    }
    List<Etkinlik> etkinlikler = [];
    _snapshot.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);

      var now = new DateTime.now();
      var formatter = new DateFormat('dd/MM/yyyy');
      String formattedDate = formatter.format(now);

      DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
          .parse(etkinlik.tarih.toString() + ' ' + etkinlik.saat.toString());

      if (formattedDate == etkinlik.tarih && etkinlikZamani.isAfter(now)) {
        etkinlikler.add(etkinlik);
      }
    });
    return etkinlikler;
  }

  Future<List<Etkinlik>> yaklasanBiletleriGetir(
      {String? aktifKullaniciId}) async {
    QuerySnapshot snapshotBiletler = await _firestore
        .collection("biletler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBiletleri")
        .orderBy("olusturulmaZamani", descending: false)
        .get();

    QuerySnapshot snapshotEtkinlikler =
        await _firestore.collection("etkinlikler").get();

    List<Etkinlik> biletler = [];
    snapshotBiletler.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      snapshotEtkinlikler.docs.forEach((DocumentSnapshot doc2) {
        Etkinlik bilet = Etkinlik.dokumandanUret(doc2);
        var now = new DateTime.now();

        DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
            .parse(bilet.tarih.toString() + ' ' + bilet.saat.toString());
        if ((etkinlik.id == bilet.id)) {
          if (etkinlikZamani.isAfter(now)) {
            biletler.add(bilet);
          }
        }
      });
    });
    return biletler;
  }

  Future<List<Etkinlik>> gecmisBiletleriGetir(
      {String? aktifKullaniciId}) async {
    QuerySnapshot snapshotBiletler = await _firestore
        .collection("biletler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBiletleri")
        .orderBy("olusturulmaZamani", descending: false)
        .get();

    QuerySnapshot snapshotEtkinlikler =
        await _firestore.collection("etkinlikler").get();

    List<Etkinlik> biletler = [];
    snapshotBiletler.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      snapshotEtkinlikler.docs.forEach((DocumentSnapshot doc2) {
        Etkinlik bilet = Etkinlik.dokumandanUret(doc2);
        var now = new DateTime.now();

        DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
            .parse(bilet.tarih.toString() + ' ' + bilet.saat.toString());
        if ((etkinlik.id == bilet.id) && etkinlikZamani.isBefore(now)) {
          biletler.add(bilet);
        }
      });
    });
    return biletler;
  }

  Future<List<Etkinlik>> begenilenEtkinlikleriGetir(
      {String? aktifKullaniciId}) async {
    QuerySnapshot snapshotBiletler = await _firestore
        .collection("begeniler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBegenileri")
        .orderBy("olusturulmaZamani", descending: false)
        .get();

    QuerySnapshot snapshotEtkinlikler =
        await _firestore.collection("etkinlikler").get();

    List<Etkinlik> biletler = [];
    snapshotBiletler.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      snapshotEtkinlikler.docs.forEach((DocumentSnapshot doc2) {
        Etkinlik bilet = Etkinlik.dokumandanUret(doc2);

        if ((etkinlik.id == bilet.id)) {
          biletler.add(bilet);
        }
      });
    });
    return biletler;
  }

  void begeniOlustur({String? etkinlikId, String? aktifKullaniciId}) async {
    await _firestore
        .collection("begeniler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBegenileri")
        .doc(etkinlikId)
        .set({"olusturulmaZamani": zaman});
  }

  Future<bool> begeniVarMi(
      {String? etkinlikId, String? aktifKullaniciId}) async {
    DocumentSnapshot doc = await _firestore
        .collection("begeniler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBegenileri")
        .doc(etkinlikId)
        .get();
    if (doc.exists) {
      return true;
    }
    return false;
  }

  void begeniKaldir({String? etkinlikId, String? aktifKullaniciId}) async {
    await _firestore
        .collection("begeniler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBegenileri")
        .doc(etkinlikId)
        .delete();
  }

  void biletOlustur({String? etkinlikId, String? aktifKullaniciId}) {
    _firestore
        .collection("biletler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBiletleri")
        .doc(etkinlikId)
        .set({"olusturulmaZamani": zaman});
  }

  Future<bool> biletVarMi(
      {String? etkinlikId, String? aktifKullaniciId}) async {
    DocumentSnapshot doc = await _firestore
        .collection("biletler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBiletleri")
        .doc(etkinlikId)
        .get();
    if (doc.exists) {
      return true;
    }
    return false;
  }

  void biletKaldir({String? etkinlikId, String? aktifKullaniciId}) async {
    await _firestore
        .collection("biletler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBiletleri")
        .doc(etkinlikId)
        .delete();
  }

  Future<void> populerlikSayisiArtir(String? etkinlikId) async {
    DocumentReference docRef =
        _firestore.collection("etkinlikler").doc(etkinlikId);
    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      int yeniPopulerlikSayisi = etkinlik.populerlikSayisi! + 1;
      docRef.update({"populerlikSayisi": yeniPopulerlikSayisi});
    }
  }

  Future<Etkinlik?> etkinlikGetir(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("etkinlikler").doc(id).get();
    if (doc.exists) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      return etkinlik;
    }
  }

  Future<void> sikayetOlustur(
      {sikayetEdenId,
      sikayetId,
      sikayetEdeninAdiSoyadi,
      sikayetEdeninMaili,
      sikayetMetni,
      sikayetEdeninTelefonu}) async {
    await _firestore
        .collection("sikayetler")
        .doc(sikayetEdenId)
        .collection("kullanicininSikayetleri")
        .doc(sikayetId)
        .set({
      "sikayetEdenId": sikayetEdenId,
      "sikayetEdeninAdiSoyadi": sikayetEdeninAdiSoyadi,
      "sikayetEdeninMaili": sikayetEdeninMaili,
      "sikayetMetni": sikayetMetni,
      "sikayetEdeninTelefonu": sikayetEdeninTelefonu,
      "olusturulmaZamani": zaman,
    });
  }

  Future<void> duyuruOlustur(
      {duyuruId,
      kullaniciId,
      etkinlikId,
      sikayetId,
      etkinlikFoto,
      etkinlikAdi,
      duyuruTipi,
      olusturulmaZamani,
      gorulduMu = "false"}) async {
    await _firestore
        .collection("duyurular")
        .doc(kullaniciId)
        .collection("kullanicininDuyurulari")
        .doc(duyuruId)
        .set({
      "duyuruId": duyuruId,
      "kullaniciId": kullaniciId,
      "sikayetId": sikayetId,
      "etkinlikId": etkinlikId,
      "etkinlikAdi": etkinlikAdi,
      "etkinlikFoto": etkinlikFoto,
      "duyuruTipi": duyuruTipi,
      "olusturulmaZamani": zaman,
      "gorulduMu": gorulduMu,
    });
  }

  Future<Etkinlik?> etkinlikZamanKontrol({String? aktifKullaniciId}) async {
    QuerySnapshot snapshotBiletler = await _firestore
        .collection("biletler")
        .doc(aktifKullaniciId)
        .collection("kullanicininBiletleri")
        .orderBy("olusturulmaZamani", descending: false)
        .get();

    QuerySnapshot snapshotEtkinlikler =
        await _firestore.collection("etkinlikler").get();

    List<Etkinlik> etkinlikler = [];

    snapshotBiletler.docs.forEach((DocumentSnapshot doc) {
      Etkinlik etkinlik = Etkinlik.dokumandanUret(doc);
      snapshotEtkinlikler.docs.forEach((DocumentSnapshot doc2) {
        Etkinlik bilet = Etkinlik.dokumandanUret(doc2);
        var now = DateTime.now();

        DateTime etkinlikZamani = DateFormat('dd/MM/yyyy hh:mm')
            .parse(bilet.tarih.toString() + ' ' + bilet.saat.toString());

        var yarimSaatOncesi = now.add(Duration(minutes: -30));

        if (etkinlik.id == bilet.id
            // && etkinlikZamani.isBefore(now) &&
            //       etkinlikZamani.isBefore(yarimSaatOncesi)
            ) {
          duyuruOlustur(
            duyuruTipi: "azKaldi",
            etkinlikAdi: etkinlik.baslik,
            etkinlikFoto: etkinlik.etkinlikResmiUrl,
            etkinlikId: etkinlik.id,
            kullaniciId: aktifKullaniciId,
          );
          print("eurekaaaaaa");
        }
      });
    });
  }
}
