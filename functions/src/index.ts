import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

export const sendNotifications = functions.firestore.document("").onCreate(async(snapshot,context)=>{
    // const {message,senderId} = snapshot.data(); 
});

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
