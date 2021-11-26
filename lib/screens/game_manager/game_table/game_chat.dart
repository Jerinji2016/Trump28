import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/main.dart';
import 'package:trump28/modals/message.dart';
import 'package:trump28/modals/njan.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/utils/firestore.dart';

class GameChat extends StatefulWidget {
  const GameChat({Key? key}) : super(key: key);

  @override
  _GameChatState createState() => _GameChatState();
}

class _GameChatState extends State<GameChat> with TickerProviderStateMixin {
  bool isChat = false;

  late AnimationController _chatAnimationController;

  @override
  void initState() {
    _chatAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    super.initState();
  }

  @override
  void dispose() {
    _chatAnimationController.dispose();
    super.dispose();
  }

  void _onChatButtonTapped() {
    setState(() => isChat = true);
    _chatAnimationController.forward();
  }

  void _onChatClosed() async {
    await _chatAnimationController.reverse();
    setState(() => isChat = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxHeight = size.height * 0.8;
    double maxWidth = size.width * 0.3;

    return isChat
        ? AnimatedBuilder(
            animation: _chatAnimationController,
            builder: (BuildContext context, Widget? child) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: maxHeight,
                  maxWidth: maxWidth,
                ),
                height: Tween<double>(
                  begin: 0,
                  end: maxHeight,
                ).animate(
                  CurvedAnimation(
                    parent: _chatAnimationController,
                    curve: Curves.fastOutSlowIn,
                  ),
                ).value,
                width: Tween<double>(
                  begin: 0,
                  end: maxWidth,
                ).animate(
                  CurvedAnimation(
                    parent: _chatAnimationController,
                    curve: Curves.fastOutSlowIn,
                  ),
                ).value,
                child: child!,
              );
            },
            child: Stack(
              children: [
                Chat(),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    child: InkWell(
                      onTap: _onChatClosed,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : ChatButton(_onChatButtonTapped);
  }
}

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  late Game game;
  final Njan njan = Njan();

  @override
  Widget build(BuildContext context) {
    game = Provider.of<Game>(context);

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      color: Colors.black12.withOpacity(0.7),
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: Firestore.getChatStream(context, game.roomId),
                initialData: [],
                builder: (context, snapshot) {
                  return ShaderMask(
                    shaderCallback: (Rect rect) {
                      return LinearGradient(
                        colors: [Colors.white12, Colors.white38, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.1, 0.3],
                      ).createShader(rect);
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Message message = snapshot.data!.elementAt(index);
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                          child: RichText(
                            text: TextSpan(
                              text: "${message.player.name}: ",
                              style: TextStyle(
                                color: message.playerNameColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: message.text,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        hintText: "Type message...",
                        hintStyle: TextStyle(
                          color: Colors.grey[300]!,
                          fontSize: 12,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: accent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: _sendMessage,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.send_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    String message = _messageController.text.trim();

    if (message.isEmpty) return;

    await Firestore.sendMessage(njan.id, game.roomId, message);
    _messageController.text = "";
  }
}

class ChatButton extends StatelessWidget {
  final Function() onTap;

  const ChatButton(this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
      color: accent.withOpacity(0.5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.chat_bubble_outline,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
