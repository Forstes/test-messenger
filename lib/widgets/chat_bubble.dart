import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: message.isFromOtherUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isFromOtherUser) CustomPaint(painter: ChatBubbleTail(isSender: !message.isFromOtherUser)),
          Column(
            crossAxisAlignment: message.isFromOtherUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: message.isFromOtherUser ? Colors.grey[300] : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.text,
                      style: TextStyle(
                        color: message.isFromOtherUser ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10.0),
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
          if (!message.isFromOtherUser) CustomPaint(painter: ChatBubbleTail(isSender: !message.isFromOtherUser)),
        ],
      ),
    );
  }
}

class ChatBubbleTail extends CustomPainter {
  final bool isSender;

  ChatBubbleTail({required this.isSender});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = (isSender ? Colors.blueAccent : Colors.grey[300])!;
    final path = Path();

    if (isSender) {
      path.moveTo(0, 10);
      path.lineTo(-10, 20);
      path.lineTo(10, 20);
      path.close();
    } else {
      path.moveTo(0, 10);
      path.lineTo(10, 20);
      path.lineTo(-10, 20);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
