const functions = require("firebase-functions");
var admin = require('firebase-admin');

admin.initializeApp();

//  ___CREATE ROOM
exports.createRoom = functions.https.onCall(async (data, context) => {
  let maxPlayers = data["type"]
  var uid = context.auth.uid;

  var userDetails = await admin.firestore().doc(`users/${uid}`).get().then((snap) => snap.data());
  var roomID = userDetails["roomId"];

  let date = new Date();
  console.log(date);
  date.setMinutes(date.getMinutes() + 30);
  console.log(date);

  var roomData = {
    roomID: roomID,
    maxPlayers: maxPlayers,
    status: 111,
    roomExpiry: admin.firestore.Timestamp.fromDate(date)
  };

  await admin.firestore().doc(`rooms/${roomID}`).set(roomData);
  roomID.id = roomID;
  console.log("room created successfully");
  return roomData;
});

//  ___JOIN SEAT
exports.joinSeat = functions.https.onCall(async (data, context) => {
  let seat = data["seat"];
  let roomId = data["roomId"];
  let name = data["name"];
  let uid = context.auth.uid;

  console.log(`${uid} - ${name} - ${seat}`);
  console.log(typeof (seat));

  var roomDetails = await admin.firestore().doc(`rooms/${roomId}`).get().then((snap) => snap.data());
  console.log(roomDetails);
  var players = roomDetails["players"];
  if (players == null)
    players = {};
  if (players[`${seat}`] != null)
    return { "status": false, "message": "Seat already occupied" };

  players[`${seat}`] = {
    "name": name,
    "id": uid,
  };

  console.log(players);

  await admin.firestore().doc(`rooms/${roomId}`).update({
    "players": players,
  });

  return { "status": true, "message": "success" };
});

//  ___SWAP SEAT
exports.swapSeat = functions.https.onCall(async (data, context) => {
  let oldSeat = data["oldSeat"];
  let newSeat = data["newSeat"];
  let roomId = data["roomId"];
  let name = data["name"];
  let uid = context.auth.uid;

  console.log(`${uid} - ${name} - ${oldSeat} - ${newSeat}`);
  console.log(typeof (seat));

  var roomDetails = await admin.firestore().doc(`rooms/${roomId}`).get().then((snap) => snap.data());
  console.log(roomDetails);
  var players = roomDetails["players"];
  if (players == null)
    players = {};
  if (players[`${newSeat}`] != null)
    return { "status": false, "message": "Seat already occupied" };

  delete players[`${oldSeat}`];

  players[`${newSeat}`] = {
    "name": name,
    "id": uid,
  };

  console.log(players);

  await admin.firestore().doc(`rooms/${roomId}`).update({
    "players": players,
  });

  return { "status": true, "message": "success" };
});

//  ___LEAVE SEAT
exports.leaveSeat = functions.https.onCall(async (data, context) => {
  let seat = data["seat"];;
  let roomId = data["roomId"];
  let uid = context.auth.uid;

  console.log(`${uid} - ${seat}`);
  console.log(typeof (seat));

  var roomDetails = await admin.firestore().doc(`rooms/${roomId}`).get().then((snap) => snap.data());
  console.log(roomDetails);
  var players = roomDetails["players"];
  if (players == null)
    return { "status": false, "message": "No seat found" };

  delete players[`${seat}`];

  await admin.firestore().doc(`rooms/${roomId}`).update({
    "players": players,
  });

  return { "status": true, "message": "success" };
});