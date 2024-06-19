import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/cubit/chat_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          title: BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (previous, current) => current is ChatDataLoaded,
            builder: (context, state) {
              if (state is ChatDataLoaded) {
                return Row(children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.lightBlue,
                    child: Text(
                      getInitials(state.contact.name),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.contact.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(state.contact.isOnline ? "В сети" : "Не в сети",
                          style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  )
                ]);
              }
              return const SizedBox();
            },
          ),
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
              child: BlocBuilder<ChatCubit, ChatState>(
                buildWhen: (previous, current) => current is MessagesListUpdated,
                builder: (context, state) {
                  List<Message> messages = [];

                  if (state is MessagesListUpdated) messages = state.messages;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final msg = messages[index];
                      bool showSeparator = false;
                      bool withTail = true;

                      if (index < messages.length - 1) {
                        showSeparator = _separatorShown(msg.dateDelivered, messages[index + 1].dateDelivered);
                      }
                      if (index > 0) {
                        withTail = msg.isFromOtherUser != messages[index - 1].isFromOtherUser;
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showSeparator) DateSeparator(date: formatSeparatorDate(msg.dateDelivered)),
                          AppChatBubble(message: msg, isWithTail: withTail),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: BottomChatPanel(
              onSendMessage: (msg) {
                setState(() => chatCubit.addMessage(widget.contactId, msg));
              },
              contactId: widget.contactId,
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
