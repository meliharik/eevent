import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();
// const database = admin.firestore();

admin.initializeApp();
const db = admin.firestore();

// export const sikayet = functions.firestore.document("sikayetler/{kullaniciId}/kullanicininSikayetleri/{sikayetId}").onUpdate((change,context) => {
//     const { message, kullaniciId} = snapshot.data();
//     const { sikayetId} = context.params;

//     const sikayet = await db.collection("sikayetler").doc(kullaniciId).get();
    
//     const sikayet2 = sikayet.data(sikayetId);
// });


export const etkinlikler = functions.firestore.document("etkinlikler/{etkinlikId}");

export const biletler = functions.firestore.document("biletler/{kullaniciId}/kullanicininBiletleri/{etkinlikId}");
// console.log('selamlar');

// exports.timerUpdate = functions.pubsub.schedule('* * * * *').onRun(() => {
//     database.doc("etkinlikler")
//     return console.log('successful timer update');
// });

//export const sendNotifications = functions.firestore.document("").on

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
 