const functions = require("firebase-functions");
var admin = require('firebase-admin');

admin.initializeApp();

exports.createRoom = functions.https.onCall(async (data, context) => {
  let maxPlayers = data["type"]
  var uid = context.auth.uid;

  var userDetails = await admin.firestore().doc(`users/${uid}`).get().then((snap) => snap.data());
  var roomID = userDetails["roomId"];

  var roomData = {
    maxPlayers: maxPlayers,
    status: 111
  };

  await admin.firestore().doc(`rooms/${roomID}`).set(roomData);
  roomID.id = roomID;
  return roomData;
});