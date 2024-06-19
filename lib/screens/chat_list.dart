import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/cubit/chat_cubit.dart';
import 'package:messenger/models/chat_litst_item.dart';
import 'package:messenger/widgets/chat_tile.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);

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
              onChanged: (v) => chatCubit.searchByContactName(v),
            ),
          ),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (previous, current) => current is ChatListUpdated,
              builder: (context, state) {
                List<ChatListItem> chats = [];
                if (state is ChatListUpdated) chats = state.chats;

                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          chatCubit.loadChatData(chats[index].contact.id);
                          context.pushNamed("chat", pathParameters: {"contactId": chats[index].contact.id.toString()});
                        },
                        child: ChatTile(chat: chats[index]));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
