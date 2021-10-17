class Njan {
  static Njan _instance = Njan._();

  factory Njan() => _instance;

  Njan._();

  static void initialize(Map user) {
    print('Njan.initialize: ');
    _instance
      ..id = user["id"]
      ..name = user["name"]
      ..roomID = user["roomId"]
      ..phone = user["phone"]
      ..email = user["email"];
  }

  late String id;
  late String name;
  late String roomID;
  late String? phone;
  late String? email;

  late bool isLoggedIn = false;
}
