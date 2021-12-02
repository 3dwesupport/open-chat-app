import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:open_chat_app/models/messages.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/chat_socket_provider.dart';
import 'package:open_chat_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class Conversation extends StatefulWidget {
  ConversationState createState() => ConversationState();
  final User chatUser;

  Conversation(this.chatUser);
}

class ConversationState extends State<Conversation> {
  @override
  void initState() {
    loadChat();
    super.initState();
  }

  List<Message> msgs = [];
  ScrollController controller = ScrollController();
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.splashBg,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        shadowColor: Colors.white,
        title: Text(
          widget.chatUser.username,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: msgs.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: msgs[index].toUID == widget.chatUser.uid
                              ? ChatBubble(
                                  clipper: ChatBubbleClipper5(
                                      type: BubbleType.sendBubble),
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 20, right: 10),
                                  backGroundColor: CustomColors.themeOrange,
                                  child: Text(
                                    msgs[index].message,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : ChatBubble(
                                  clipper: ChatBubbleClipper5(
                                      type: BubbleType.receiverBubble),
                                  margin: EdgeInsets.only(top: 20, left: 10),
                                  backGroundColor: Colors.white,
                                  child: Text(
                                    msgs[index].message,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ));
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Write Something",
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColors.themeOrange, width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    suffixIcon: IconButton(
                        enableFeedback: true,
                        color: CustomColors.themeOrange,
                        tooltip: "Send Message",
                        onPressed: () => messageController.text.length > 0
                            ? sendMessage()
                            : null,
                        icon: Icon(Icons.send)),
                  ),
                  controller: messageController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadChat() async {
    await Provider.of<ChatSocketProvider>(context, listen: false)
        .getConversation(context, widget.chatUser, reload);
    msgs =
        Provider.of<ChatSocketProvider>(context, listen: false).currentChatMsgs;
    reload();
  }

  sendMessage() async {
    await Provider.of<ChatSocketProvider>(context, listen: false)
        .sendMessage(context, messageController.text, widget.chatUser.uid);
    messageController.clear();
    reload();
  }

  reload() async {
    setState(() {
      msgs = Provider.of<ChatSocketProvider>(context, listen: false)
          .currentChatMsgs;
    });
    ScrollPosition position = controller.position;
    double val = position.maxScrollExtent + 30;
    setState(() {
      controller.animateTo(
        val,
        curve: Curves.ease,
        duration: Duration(milliseconds: 300),
      );
    });
  }
}
