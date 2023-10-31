import 'package:anitection/screens/chat/message_buble.dart';
import 'package:flutter/material.dart';

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
