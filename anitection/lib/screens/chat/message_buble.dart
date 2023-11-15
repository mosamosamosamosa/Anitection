
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';

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

