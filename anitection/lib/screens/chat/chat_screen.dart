import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/institution_title.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends ConsumerState<ChatScreen> {
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
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InstitutionMessageBubble(
                  text: "ご連絡ありがとうございますあいうえおかきくけおこさしすれこ\n\n松本",
                  avatarIconUrl:
                      "https://img.furusato-tax.jp/img/x/original/feature/form/details/20211129/gpfd_107bfa9e0ad3c76c4afea5461d79acf480140bda.jpg",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: PersonMessageBubble(
                  text: "にゃにゃにゃにゃんんんんにゃんわんぱうぱうぱうにゃんにゃにゃぱうぱう",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: PersonMessageBubble(
                  text: "にゃにゃにゃにゃんんんん",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InstitutionMessageBubble(
                    text: "ご連絡ありがとうございますあいうえおかきくけおこさしすれこ\n\n松本",
                  avatarIconUrl: "https://img.furusato-tax.jp/img/x/original/feature/form/details/20211129/gpfd_107bfa9e0ad3c76c4afea5461d79acf480140bda.jpg",
                ),
              )
            ],
          )
        ],
      ),
    );
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
        )
      ],
    );
  }
}
