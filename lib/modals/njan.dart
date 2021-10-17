class Njan {
  static Njan _instance = Njan._();

  factory Njan() => _instance;

  Njan._();

  late String id;
  late String name;

  late bool isLoggedIn = false;
}
