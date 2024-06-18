import 'package:flutter/material.dart';
import 'package:messenger/models/chat_litst_item.dart';
import 'package:messenger/utils/date_time.dart';
import 'package:messenger/utils/initials.dart';

class ChatTile extends StatelessWidget {
  final ChatListItem chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.grey.shade300),
          bottom: BorderSide(width: 0.5, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.lightBlue,
              child: Text(
                getInitials(chat.contact.name),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.contact.name, style: const TextStyle(height: 1.4, fontWeight: FontWeight.bold)),
                  if (chat.lastMsg != null)
                    RichText(
                      textDirection: TextDirection.ltr,
                      text: TextSpan(
                        style: const TextStyle(fontSize: 13),
                        children: <TextSpan>[
                          if (!chat.lastMsg!.isFromOtherUser) const TextSpan(text: "Вы: "),
                          TextSpan(text: chat.lastMsg!.text, style: const TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (chat.lastMsg != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(formatDateTime(chat.lastMsg!.dateDelivered),
                    style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ),
            ),
        ],
      ),
    );
  }
}
