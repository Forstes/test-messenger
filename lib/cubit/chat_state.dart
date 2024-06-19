part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatListUpdated extends ChatState {
  final List<ChatListItem> chats;

  const ChatListUpdated({required this.chats});
}

final class ChatListLoading extends ChatState {}

final class MessagesLoading extends ChatState {}

final class MessagesListUpdated extends ChatState {
  final List<Message> messages;

  const MessagesListUpdated({required this.messages});
}

final class ChatDataLoading extends ChatState {}

final class ChatDataLoaded extends MessagesListUpdated {
  final Contact contact;

  const ChatDataLoaded({required this.contact, required super.messages});
}
