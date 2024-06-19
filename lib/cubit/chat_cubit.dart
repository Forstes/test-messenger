import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/models/chat_litst_item.dart';
import 'package:messenger/models/contact.dart';
import 'package:messenger/models/message.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final List<Contact> contacts = [
    Contact(id: 1, isOnline: true, name: "Александр Плюшкин"),
    Contact(id: 2, isOnline: true, name: "Влад Седых"),
  ];

  final List<ChatListItem> chats = [
    ChatListItem(
        contact: Contact(id: 1, isOnline: true, name: "Александр Плюшкин"),
        lastMsg: Message(
          dateDelivered: DateTime.now().subtract(const Duration(minutes: 1)),
          text: "Поешь",
          isReaded: true,
          isFromOtherUser: false,
          contactId: 1,
        )),
    ChatListItem(
        contact: Contact(id: 2, isOnline: true, name: "Влад Седых"),
        lastMsg: Message(
          dateDelivered: DateTime.now().subtract(const Duration(minutes: 5)),
          text: "Погуляй",
          isReaded: true,
          isFromOtherUser: false,
          contactId: 2,
        )),
    /*   ChatListItem(
        contact: Contact(id: 3, isOnline: true, name: "Владимир Винницкий"),
        lastMsg: Message(
          dateDelivered: DateTime.now().subtract(const Duration(days: 1)),
          text: "Привет",
          isReaded: true,
          isFromOtherUser: false,
        )) */
  ];

  final List<Message> messages = [
    Message(
      text: "Погуляй",
      dateDelivered: DateTime.now().subtract(const Duration(minutes: 5)),
      isReaded: true,
      isFromOtherUser: true,
      contactId: 2,
    ),
    Message(
      text: "Поешь",
      dateDelivered: DateTime.now().subtract(const Duration(minutes: 1)),
      isReaded: true,
      isFromOtherUser: true,
      contactId: 1,
    ),
    Message(
      text: "Привет! Мы тебе пирог оставили",
      dateDelivered: DateTime.now().subtract(const Duration(minutes: 3)),
      isReaded: true,
      isFromOtherUser: true,
      contactId: 1,
    ),
    Message(
      text: "Привет!",
      dateDelivered: DateTime.now().subtract(const Duration(days: 1, hours: 14)),
      isReaded: true,
      isFromOtherUser: false,
      contactId: 1,
    ),
    Message(
      text: "ЭЙ!",
      dateDelivered: DateTime.now().subtract(const Duration(days: 2)),
      isReaded: true,
      isFromOtherUser: false,
      contactId: 1,
    ),
    Message(
      text: "А??",
      dateDelivered: DateTime.now().subtract(const Duration(days: 2)),
      isReaded: true,
      isFromOtherUser: false,
      contactId: 1,
    ),
    Message(
      text: "А??",
      dateDelivered: DateTime.now().subtract(const Duration(days: 2)),
      isReaded: true,
      isFromOtherUser: true,
      contactId: 1,
    ),
  ];

  void loadChatList() {
    emit(ChatListUpdated(chats: chats));
  }

  void loadChatData(int contactId) {
    emit(ChatDataLoading());
    emit(
      ChatDataLoaded(
          contact: contacts.firstWhere((v) => v.id == contactId),
          messages: messages.where((v) => v.contactId == contactId).toList()),
    );
  }

  void addMessage(int contactId, Message msg) {
    messages.insert(0, msg);
    emit(MessagesListUpdated(messages: messages.where((v) => v.contactId == contactId).toList()));

    final chat = chats.firstWhere((v) => v.contact.id == contactId);
    chat.lastMsg = msg;
    emit(ChatListUpdated(chats: List.of(chats)));
  }

  void searchByContactName(String query) {
    emit(ChatListLoading());
    emit(ChatListUpdated(
        chats: chats.where((v) => v.contact.name.toLowerCase().contains(query.toLowerCase())).toList()));
  }
}
