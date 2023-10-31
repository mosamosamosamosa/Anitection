import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/institution_title.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/screens/chat/chat_bottom_menu.dart';
import 'package:anitection/screens/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                ChatBottomMenu(
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


// SvgPicture.asset("assets/svg/img_chat_animal_pad.svg"),
