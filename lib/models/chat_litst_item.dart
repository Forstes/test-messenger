import 'package:messenger/models/contact.dart';
import 'package:messenger/models/message.dart';

class ChatListItem {
  Contact contact;
  Message? lastMsg;

  ChatListItem({required this.contact, this.lastMsg});
}
