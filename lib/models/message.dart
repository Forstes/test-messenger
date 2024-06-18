class Message {
  bool isFromOtherUser;
  String text;
  DateTime dateDelivered;
  bool isReaded;

  Message({required this.isFromOtherUser, required this.text, required this.dateDelivered, required this.isReaded});
}
