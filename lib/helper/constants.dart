import 'package:flutter/material.dart';
import 'package:trump28/modals/cards.dart';

const int TOTAL_PLAY_CARDS = 6;

const Color BLACK = Colors.black;
const Color RED = Colors.red;

const double SMALL_SCALE = .35;
const double LARGE_SCALE = 1.3;

const double CARDS_8_OFFSET = 0.094,
    CARDS_6_OFFSET = 0.12,
    CARDS_4_OFFSET = 0.166,
    CARDS_3_OFFSET = 0.2;

enum LobbyState { START, JOIN, CREATE, WAITING }

ValueNotifier<LobbyState> lobbyState = new ValueNotifier(LobbyState.START);
ValueNotifier<String> name = new ValueNotifier("Player");

Map<String, Cards> deck = {
  "SA": new Cards(
    id: "SA",
    name: "A",
    value: 1,
    suitNo: 1,
    color: BLACK,
  ),
  "SK": new Cards(
    id: "SK",
    name: "K",
    value: 0,
    suitNo: 1,
    color: BLACK,
  ),
  "SQ": new Cards(
    id: "SQ",
    name: "Q",
    value: 0,
    suitNo: 1,
    color: BLACK,
  ),
  "SJ": new Cards(
    id: "SJ",
    name: "J",
    value: 3,
    suitNo: 1,
    color: BLACK,
  ),
  "S10": new Cards(
    id: "S10",
    name: "10",
    value: 1,
    suitNo: 1,
    color: BLACK,
  ),
  "S9": new Cards(
    id: "S9",
    name: "9",
    value: 2,
    suitNo: 1,
    color: BLACK,
  ),
  "S8": new Cards(
    id: "S8",
    name: "8",
    value: 0,
    suitNo: 1,
    color: BLACK,
  ),
  "S7": new Cards(
    id: "S7",
    name: "7",
    value: 0,
    suitNo: 1,
    color: BLACK,
  ),
  "HA": new Cards(
    id: "HA",
    name: "A",
    value: 1,
    suitNo: 2,
    color: RED,
  ),
  "HK": new Cards(
    id: "HK",
    name: "K",
    value: 0,
    suitNo: 2,
    color: RED,
  ),
  "HQ": new Cards(
    id: "HQ",
    name: "Q",
    value: 0,
    suitNo: 2,
    color: RED,
  ),
  "HJ": new Cards(
    id: "HJ",
    name: "J",
    value: 3,
    suitNo: 2,
    color: RED,
  ),
  "H10": new Cards(
    id: "H10",
    name: "10",
    value: 1,
    suitNo: 2,
    color: RED,
  ),
  "H9": new Cards(
    id: "H9",
    name: "9",
    value: 2,
    suitNo: 2,
    color: RED,
  ),
  "H8": new Cards(
    id: "H8",
    name: "8",
    value: 0,
    suitNo: 2,
    color: RED,
  ),
  "H7": new Cards(
    id: "H7",
    name: "7",
    value: 0,
    suitNo: 2,
    color: RED,
  ),
  "CA": new Cards(
    id: "CA",
    name: "A",
    value: 1,
    suitNo: 3,
    color: BLACK,
  ),
  "CK": new Cards(
    id: "CK",
    name: "K",
    value: 0,
    suitNo: 3,
    color: BLACK,
  ),
  "CQ": new Cards(
    id: "CQ",
    name: "Q",
    value: 0,
    suitNo: 3,
    color: BLACK,
  ),
  "CJ": new Cards(
    id: "CJ",
    name: "J",
    value: 3,
    suitNo: 3,
    color: BLACK,
  ),
  "C10": new Cards(
    id: "C10",
    name: "10",
    value: 1,
    suitNo: 3,
    color: BLACK,
  ),
  "C9": new Cards(
    id: "C9",
    name: "9",
    value: 2,
    suitNo: 3,
    color: BLACK,
  ),
  "C8": new Cards(
    id: "C8",
    name: "8",
    value: 0,
    suitNo: 3,
    color: BLACK,
  ),
  "C7": new Cards(
    id: "C7",
    name: "7",
    value: 0,
    suitNo: 3,
    color: BLACK,
  ),
  "DA": new Cards(
    id: "DA",
    name: "0",
    value: 1,
    suitNo: 3,
    color: RED,
  ),
  "DK": new Cards(
    id: "DK",
    name: "3",
    value: 0,
    suitNo: 4,
    color: RED,
  ),
  "DQ": new Cards(
    id: "DQ",
    name: "Q",
    value: 0,
    suitNo: 4,
    color: RED,
  ),
  "DJ": new Cards(
    id: "DJ",
    name: "J",
    value: 3,
    suitNo: 4,
    color: RED,
  ),
  "D10": new Cards(
    id: "D10",
    name: "10",
    value: 1,
    suitNo: 4,
    color: RED,
  ),
  "D9": new Cards(
    id: "D9",
    name: "9",
    value: 2,
    suitNo: 4,
    color: RED,
  ),
  "D8": new Cards(
    id: "D8",
    name: "8",
    value: 0,
    suitNo: 4,
    color: RED,
  ),
  "D7": new Cards(
    id: "D7",
    name: "7",
    value: 0,
    suitNo: 4,
    color: RED,
  ),
};

Map<String, Cards> extraCards = {
  "S6": new Cards(
    id: "S6",
    name: "6",
    value: 0,
    suitNo: 1,
    color: BLACK,
  ),
  "H6": new Cards(
    id: "H6",
    name: "6",
    value: 0,
    suitNo: 2,
    color: RED,
  ),
  "C6": new Cards(
    id: "C6",
    name: "6",
    value: 0,
    suitNo: 3,
    color: BLACK,
  ),
  "D6": new Cards(
    id: "D6",
    name: "6",
    value: 0,
    suitNo: 4,
    color: RED,
  ),
};
