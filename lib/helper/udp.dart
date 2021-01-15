import 'dart:convert';
import 'dart:io';

class UDP {
  RawDatagramSocket socket;
  String address;
  InternetAddress ip;
  static const int PORT = 5558;
  // 8889;

  UDP(this.address) {
    this.ip = new InternetAddress(address, type: InternetAddressType.IPv4);
  }
  connect() async {
    await RawDatagramSocket.bind(this.ip, PORT)
        .then((RawDatagramSocket udpSocket) {
      this.socket = udpSocket;
      print("Datagram Socket binded to ${ip.address}");
    });
  }

  onDataHandler(Function callback) {
    socket.listen((RawSocketEvent event) {
      Datagram dg = socket.receive();
      if (dg != null) callback(String.fromCharCodes(dg.data));
    });
  }

  close() {
    socket.close();
    print("Closing socket on ${socket.address}");
  }

  sendData(String data, String toIp) {
    List<int> encodedData = utf8.encode(data);
    InternetAddress to =
        new InternetAddress(toIp, type: InternetAddressType.IPv4);
    try {
      socket.send(encodedData, to, PORT);
      print("Data sent: $data");
    } catch (e) {
      print("Failed to Send: ${e.toString()}");
    }
  }
}
