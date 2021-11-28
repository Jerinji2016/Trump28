const functions = require("firebase-functions");
var admin = require('firebase-admin');

admin.initializeApp();

async function getRoomDetails(roomID) {
  return await admin.firestore().doc(`rooms/${roomID}`).get().then((snap) => snap.data());
}

//  ___CREATE ROOM
//  @param type: <int> [4/6] no of players in game
exports.createRoom = functions.https.onCall(async (data, context) => {
  let maxPlayers = data["type"]
  var uid = context.auth.uid;

  var userDetails = await admin.firestore().doc(`users/${uid}`).get().then((snap) => snap.data());
  var roomID = userDetails["roomId"];

  let date = new Date();
  date.setMinutes(date.getMinutes() + 30);
  console.log(date);

  var roomData = {
    roomID: roomID,
    maxPlayers: maxPlayers,
    status: 111,
    roomExpiry: admin.firestore.Timestamp.fromDate(date)
  };

  await admin.firestore().collection(`rooms/${roomID}/chat`).get().then(snap => {
    snap.forEach(doc => {
      doc.ref.delete();
    });
    console.log("chat cleared...");
  });

  await admin.firestore().doc(`rooms/${roomID}`).set(roomData);
  roomID.id = roomID;
  console.log("room created successfully");
  return roomData;
});

//  ___JOIN SEAT
//  @param seat  : <int> seat number to join
//  @param roomId: <string> Room ID
//  @param name  : <string> player name
exports.joinSeat = functions.https.onCall(async (data, context) => {
  let seat = data["seat"];
  let roomId = data["roomId"];
  let name = data["name"];
  let uid = context.auth.uid;

  console.log(`${uid} - ${name} - ${seat}`);
  console.log(typeof (seat));

  var roomDetails = await getRoomDetails(roomId);
  console.log(roomDetails);
  var players = roomDetails["players"];
  if (players == null)
    players = {};
  if (players[`${seat}`] != null)
    return { "status": false, "message": "Seat already occupied" };

  // players[seat] = {
  //   "name": name,
  //   "id": uid,
  //   "ready": false,
  // };

  //  test code____
  let testPlayer = {
    1: {
      "name": "Jenson",
      "id": "jhsdvgfvksdvg",
      "ready": true,
    },
    4: {
      "name": "Jerin",
      "id": "imaKln6siYnS3YUDkWHnwLAKbtIE",
      "ready": false,
    },
    3: {
      "name": "Shafas",
      "id": "sdhjfkabsdjfhgbas",
      "ready": true,
    },
    2: {
      "name": "Raman",
      "id": "sdjfkbsdljgkhbasd",
      "ready": true,
    },
    5: {
      "name": "Muscle",
      "id": "sdfkjvsdgsdfkv",
      "ready": true,
    },
    6: {
      "name": "Shukkooor",
      "id": "iylkgjvkucyjsdvf",
      "ready": true,
    }
  };

  for (let i = 1; i <= roomDetails["maxPlayers"]; i++)
    players[i] = testPlayer[i];

  //  test code end___

  console.log(players);

  await admin.firestore().doc(`rooms/${roomId}`).update({
    "players": players,
  });

  return { "status": true, "message": "success" };
});

//  ___PLAYER READY
//  @param seatNo     : <int> player seat number
//  @param readyStatus: <boolean> ready -> true, not ready -> false
//  @param roomId     : <string> Room ID
exports.playerReady = functions.https.onCall(async (data, context) => {
  let seatNo = data["seatNo"];
  let roomId = data["roomId"];
  let readyStatus = data["readyStatus"];

  var roomDetails = await getRoomDetails(roomId);
  var players = roomDetails["players"];

  players[seatNo]["ready"] = readyStatus;

  var keys = Object.keys(players);
  var allPlayersReady = true;
  for (let i = 0; i < keys.length; i++) {
    if (!players[keys[i]]["ready"]) {
      allPlayersReady = false;
      break;
    }
  }

  var updateData = {
    "players": players
  };

  if (allPlayersReady) {
    updateData["status"] = 112;

    //  initialize game details
    const maxPlayers = roomDetails["maxPlayers"];
    let randomPlayer = Math.ceil(Math.random() * maxPlayers);
    // updateData["dealerId"] = players[randomPlayer]["id"];

    //  ___remove test code
    updateData["dealerId"] = players[4]["id"];
  }

  console.log(updateData);

  await admin.firestore().doc(`rooms/${roomId}`).update(updateData);
  return false;
});

//  ___SWAP SEAT
//  @param oldSeat: <int> prevoiusly set seat
//  @param newSeat: <int> new seat to be changed to
//  @param roomId : <string> Room ID
//  @param name   : <string> player name
exports.swapSeat = functions.https.onCall(async (data, context) => {
  let oldSeat = data["oldSeat"];
  let newSeat = data["newSeat"];
  let roomId = data["roomId"];
  let name = data["name"];
  let uid = context.auth.uid;

  console.log(`${uid} - ${name} - ${oldSeat} - ${newSeat}`);
  console.log(typeof (seat));

  var roomDetails = await getRoomDetails(roomId);
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
//  @param seat  : <int> current seat
//  @param roomId: <string> Room ID
exports.leaveSeat = functions.https.onCall(async (data, context) => {
  let seat = data["seat"];;
  let roomId = data["roomId"];

  var roomDetails = await getRoomDetails(roomId);

  var players = roomDetails["players"];
  if (players == null)
    return { "status": false, "message": "No seat found" };

  delete players[`${seat}`];

  await admin.firestore().doc(`rooms/${roomId}`).update({
    "players": players,
  });

  return { "status": true, "message": "success" };
});

//  ___DEAL FIRST ROUND
//  @param roomId             : <string> Room ID
//  @param shuffledCardsString: <string> Shuffled cards string joined with '-' seperator
//  @return [remaining cards]
exports.dealFirstRound = functions.https.onCall(async (data, context) => {
  var roomId = data["roomId"];
  var shuffledCardsString = data["shuffledCardString"];
  var shuffledCards = shuffledCardsString.split("-");

  const roomDetails = await getRoomDetails(roomId);
  var players = roomDetails["players"];
  var dealerId = roomDetails["dealerId"];
  let cardsPerPlayer = (roomDetails["maxPlayers"] == 4) ? 4 : 3;

  var nextBidderSeat;

  Object.keys(players).forEach(playerSeat => {
    var player = players[playerSeat];
    var cards = [];

    for (let i = 0; i < cardsPerPlayer; i++)
      cards.push(shuffledCards.pop());

    if(player["id"] == dealerId)
      nextBidderSeat = parseInt(playerSeat) + 1;    

    player["cards"] = cards;
    console.log(player);
  });

  console.log(nextBidderSeat);

  if(nextBidderSeat > roomDetails["maxPlayers"])
    nextBidderSeat = 1;

  var gameUpdate = {
    "players": players,
    "remainingCards": shuffledCards,
    "status": 113,
    "nextBidderId": players[nextBidderSeat]["id"]
  };

  console.log(gameUpdate);
  await admin.firestore().doc(`rooms/${roomId}`).update(gameUpdate);
  return true;
});