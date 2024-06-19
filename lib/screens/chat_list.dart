import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/models/chat_litst_item.dart';
import 'package:messenger/models/contact.dart';
import 'package:messenger/models/message.dart';
import 'package:messenger/widgets/chat_tile.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  final List<ChatListItem> chats = [
    ChatListItem(
        contact: Contact(id: 1, isOnline: true, name: "Александр Плюшкин"),
        lastMsg: Message(
          dateDelivered: DateTime.now().subtract(const Duration(minutes: 1)),
          text: "Поешь",
          isReaded: true,
          isFromOtherUser: false,
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Чаты",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 30),
            child: TextField(
              decoration: InputDecoration(
                fillColor: const Color(0xFFEDF2F6),
                filled: true,
                hintText: 'Поиск',
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      context.pushNamed("chat", pathParameters: {"contactId": chats[index].contact.id.toString()});
                    },
                    child: ChatTile(chat: chats[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
