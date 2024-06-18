import 'package:go_router/go_router.dart';
import 'package:messenger/screens/chat.dart';
import 'package:messenger/screens/chat_list.dart';
import 'package:messenger/screens/not_found.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "chat_list",
      builder: (context, state) => const ChatListScreen(),
    ),
    GoRoute(
      path: '/chat/:contactId',
      name: "chat",
      builder: (context, state) {
        final contactId = int.tryParse(state.pathParameters['contactId'] ?? "");
        if (contactId == null) return const NotFoundScreen();

        return ChatScreen(contactId: contactId);
      },
    ),
  ],
);
