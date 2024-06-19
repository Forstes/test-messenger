import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger/models/message.dart';
import 'package:messenger/widgets/image_rounded.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class AppChatBubble extends StatelessWidget {
  const AppChatBubble({super.key, required this.message, required this.isWithTail});

  final Message message;
  final bool isWithTail;

  @override
  Widget build(BuildContext context) {
    final bubbleType = message.isFromOtherUser ? BubbleType.receiverBubble : BubbleType.sendBubble;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: message.isFromOtherUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          SizedBox(
            width: message.attachedImg != null ? 230 : null,
            child: ChatBubble(
              clipper: isWithTail ? ChatBubbleClipper2(type: bubbleType) : ChatBubbleClipper5(type: bubbleType),
              alignment: Alignment.topRight,
              backGroundColor: message.isFromOtherUser ? const Color(0xFFEDF2F6) : const Color(0xFF3CED78),
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
                        Text(message.text, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 12.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('HH:mm').format(message.dateDelivered),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            if (!message.isFromOtherUser)
                              Icon(
                                message.isReaded ? Icons.done_all : Icons.done,
                                size: 14.0,
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
