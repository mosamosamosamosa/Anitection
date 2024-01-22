import 'package:anitection/constants.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/message/message.dart';
import 'package:anitection/models/user/user.dart';
import 'package:anitection/providers/institution.dart';
import 'package:anitection/screens/chat/message_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageList extends ConsumerWidget {
  const MessageList({super.key, required this.messages, required this.me});

  final List<Model<MessageAttributes>> messages;
  final User? me;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding:
      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      children: [
        for (final message in messages)
          MessageBubble(
            message: message,
            me: me,
          )
      ],
    );
  }
}

class MessageBubble extends ConsumerWidget {
  const MessageBubble({super.key, required this.message, required this.me});
  final Model<MessageAttributes> message;
  final User? me;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (me?.id == message.attributes.user?.data.id) {
      return Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: PersonMessageBubble(
          text: message.attributes.content,
        ),
      );
    } else {
      final institution = ref.watch(institutionFutureProvider(message.attributes.institution?.data.id ?? 0));
      return Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: InstitutionMessageBubble(
          text: message.attributes.content,
          avatarIconUrl:
          AppConstants.mediaServerBaseUrl + (institution.valueOrNull?.attributes.image?.data.attributes.url ?? ""),
        ),
      );
    }
  }
}
