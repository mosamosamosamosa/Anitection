import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/institution_title.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/message/message.dart';
import 'package:anitection/providers/auth_controller.dart';
import 'package:anitection/providers/client.dart';
import 'package:anitection/screens/chat/chat_bottom_menu.dart';
import 'package:anitection/screens/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.institutionId});
  final int institutionId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  bool _isInputMode = false;
  FocusNode chatTextFieldFocusNode = FocusNode();
  List<Model<MessageAttributes>> messages = [];
  final textController = TextEditingController();

  @override
  void initState() {
    chatTextFieldFocusNode.addListener(() {
      setState(() {
        _isInputMode = chatTextFieldFocusNode.hasFocus;
      });
    });
    ref.read(anitectionClientProvider).getMessages(
      widget.institutionId,
      // ref.read(authControllerProvider).valueOrNull?.id ?? 0,
      // ref.read(authControllerProvider).valueOrNull?.id ?? 0,
      // 1,
      // 20,
    ).then((value) {
      setState(() {
        messages = value.data;
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
    final me = ref.watch(authControllerProvider);
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
                  child: MessageList(messages: messages, me: me.valueOrNull,),
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
                                  controller: textController,
                              focusNode: chatTextFieldFocusNode,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "メッセージを入力",

                              ),
                            )),
                            IconButton(onPressed: () {
                              ref.read(anitectionClientProvider).createMessage({
                                "data": {
                                  "content": textController.text,
                                  "institution": widget.institutionId,
                                  "sender": me.valueOrNull?.id,
                                  "read": false,
                                }
                              }).then((value) {
                                // reload
                                ref.read(anitectionClientProvider).getMessages(
                                  widget.institutionId,
                                  // ref.read(authControllerProvider).valueOrNull?.id ?? 0,
                                  // ref.read(authControllerProvider).valueOrNull?.id ?? 0,
                                  // 1,
                                  // 20,
                                ).then((value) {
                                  textController.clear();
                                  setState(() {
                                    messages = value.data;
                                  });
                                });
                              });

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
