import 'package:anitection/models/base.dart';
import 'package:anitection/models/message/message.dart';
import 'package:anitection/models/user/user.dart';
import 'package:anitection/screens/chat/message_buble.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messages, required this.me});

  final List<Model<MessageAttributes>> messages;
  final User? me;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      children: [
        for (final message in messages)
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: InstitutionMessageBubble(
              text: message.attributes.content ?? "",
              avatarIconUrl:
              message.attributes.institution?.data.attributes.image?.data.attributes.url ?? "",
            ),
          ),
      ],
    );
  }
}
