import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/institution_title.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  bool _isInputMode = false;
  FocusNode chatTextFieldFocusNode = FocusNode();

  @override
  void initState() {
    chatTextFieldFocusNode.addListener(() {
      setState(() {
        _isInputMode = chatTextFieldFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    chatTextFieldFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: AppBar(
          centerTitle: true,
          elevation: 4,
          backgroundColor: const Color(0xFFC3EB89),
          title: const Padding(
            padding: EdgeInsets.all(16),
            child: InstitutionTitle(title: "あにまる保護施設"),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: NavUpButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          Column(
            children: [
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    chatTextFieldFocusNode.unfocus();
                    setState(() {
                      _isInputMode = false;
                    });
                  },
                  child: const MessageList(),
                ),
              ),
              if (_isInputMode)
                // チャットの入力領域
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, -2),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                                child: TextField(
                              focusNode: chatTextFieldFocusNode,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "メッセージを入力",

                              ),
                            )),
                            IconButton(onPressed: () {

                            }, icon: const Icon(Icons.send)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              else
                InstitutionBottomMenu(
                  onKeyboardPressed: () {
                    setState(() {
                      _isInputMode = !_isInputMode;
                      chatTextFieldFocusNode.requestFocus();
                    });
                  },
                  onMenuPressed: () {},
                ),
            ],
          )
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      children: const [
        Padding(
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: InstitutionMessageBubble(
            text: "ご連絡ありがとうございますあいうえおかきくけおこさしすれこ\n\n松本",
            avatarIconUrl:
            "https://img.furusato-tax.jp/img/x/original/feature/form/details/20211129/gpfd_107bfa9e0ad3c76c4afea5461d79acf480140bda.jpg",
          ),
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: PersonMessageBubble(
            text: "にゃにゃにゃにゃんんんんにゃんわんぱうぱうぱうにゃんにゃにゃぱうぱう",
          ),
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: PersonMessageBubble(
            text: "にゃにゃにゃにゃんんんん",
          ),
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: InstitutionMessageBubble(
            text: "ご連絡ありがとうございますあいうえおかきくけおこさしすれこ\n\n松本",
            avatarIconUrl:
            "https://img.furusato-tax.jp/img/x/original/feature/form/details/20211129/gpfd_107bfa9e0ad3c76c4afea5461d79acf480140bda.jpg",
          ),
        )
      ],
    );
  }
}

class InstitutionBottomMenu extends StatelessWidget {
  const InstitutionBottomMenu({
    super.key,
    required this.onMenuPressed,
    required this.onKeyboardPressed,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onKeyboardPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onKeyboardPressed,
            child: SvgPicture.asset(
              "assets/svg/ic_orange_keyboard.svg",
              width: 32,
              height: 32,
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: onMenuPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const StrokeText(
                      text: "メニュー",
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      strokeWidth: 4,
                      strokeColor: Colors.white,
                      textColor: Color(0xFF573F1B),
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    const SizedBox(width: 2),
                    CustomPaint(
                      painter: TrianglePainter(),
                      size: const Size(12, 12),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    var paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);

    var borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class InstitutionMessageBubble extends StatelessWidget {
  const InstitutionMessageBubble(
      {super.key, required this.text, this.avatarIconUrl});

  final String text;
  final String? avatarIconUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                avatarIconUrl ?? "",
              ),
            ),
          ),
        ),
        ChatBubble(
          clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
          backGroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(4),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF444444)),
            ),
          ),
        ),
      ],
    );
  }
}

class PersonMessageBubble extends StatelessWidget {
  const PersonMessageBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ChatBubble(
          clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
          backGroundColor: const Color(0xFFF7FDEF),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 4,
                  right: 30,
                  bottom: 4,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  text,
                  style: const TextStyle(color: Color(0xFF444444)),
                ),
              ),
              SvgPicture.asset("assets/svg/img_chat_animal_pad.svg"),
            ],
          ),
        )
      ],
    );
  }
}

// SvgPicture.asset("assets/svg/img_chat_animal_pad.svg"),
