import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/models/message.dart';
import 'package:messenger/utils/date_time.dart';
import 'package:messenger/utils/initials.dart';
import 'package:messenger/widgets/bottom_chat_panel.dart';
import 'package:messenger/widgets/chat_bubble.dart';
import 'package:messenger/widgets/date_separator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.contactId});

  final int contactId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [
    Message(
        text: "Помоги!",
        dateDelivered: DateTime.now().subtract(const Duration(minutes: 6)),
        isReaded: true,
        isFromOtherUser: true),
    Message(
        text: "Помоги!",
        dateDelivered: DateTime.now().subtract(const Duration(minutes: 7)),
        isReaded: true,
        isFromOtherUser: true),
    Message(
        text: "Чего тебе?",
        dateDelivered: DateTime.now().subtract(const Duration(days: 1, hours: 14)),
        isReaded: true,
        isFromOtherUser: false),
    Message(
        text: "Чего тебе?",
        dateDelivered: DateTime.now().subtract(const Duration(days: 1, hours: 15)),
        isReaded: true,
        isFromOtherUser: false),
    Message(
        text: "ЭЙ!",
        dateDelivered: DateTime.now().subtract(const Duration(days: 2)),
        isReaded: true,
        isFromOtherUser: false),
    Message(
        text: "А??",
        dateDelivered: DateTime.now().subtract(const Duration(days: 2)),
        isReaded: true,
        isFromOtherUser: false),
    Message(
        text: "А??",
        dateDelivered: DateTime.now().subtract(const Duration(days: 2)),
        isReaded: true,
        isFromOtherUser: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          title: Row(children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.lightBlue,
              child: Text(
                getInitials("Виктор Власов"),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Александр Плюшкин',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("В сети", style: TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            )
          ]),
          leading: GestureDetector(
            child: const Icon(Icons.chevron_left, size: 35),
            onTap: () => context.pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: Colors.grey,
              height: 0.1,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final msg = messages[index];
                  bool showSeparator = false;
                  if (index < messages.length - 1) {
                    showSeparator = _separatorShown(msg.dateDelivered, messages[index + 1].dateDelivered);
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showSeparator) DateSeparator(date: formatSeparatorDate(msg.dateDelivered)),
                      AppChatBubble(message: msg),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: BottomChatPanel(
              onSendMessage: (msg) {
                setState(() => messages.insert(0, msg));
              },
            ),
          ),
        ],
      ),
    );
  }

  _separatorShown(DateTime prevDate, DateTime currDate) {
    return prevDate.day != currDate.day || prevDate.month != currDate.month || prevDate.year != currDate.year;
  }
}
