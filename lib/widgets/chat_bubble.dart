import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger/models/message.dart';
import 'package:messenger/widgets/image_rounded.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class AppChatBubble extends StatelessWidget {
  const AppChatBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: message.isFromOtherUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          SizedBox(
            width: message.attachedImg != null ? 230 : null,
            child: ChatBubble(
              clipper:
                  ChatBubbleClipper1(type: message.isFromOtherUser ? BubbleType.receiverBubble : BubbleType.sendBubble),
              alignment: Alignment.topRight,
              backGroundColor: Colors.blue,
              child: Column(
                crossAxisAlignment: message.attachedImg != null ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
                children: [
                  if (message.attachedImg != null)
                    ImageRounded(
                      image: message.attachedImg!,
                      width: 200,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            color: message.isFromOtherUser ? Colors.black : Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('HH:mm').format(message.dateDelivered),
                              style: TextStyle(
                                color: message.isFromOtherUser ? Colors.black54 : Colors.white70,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            if (!message.isFromOtherUser)
                              Icon(
                                message.isReaded ? Icons.done_all : Icons.done,
                                size: 16.0,
                                color: message.isFromOtherUser ? Colors.black54 : Colors.white70,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
