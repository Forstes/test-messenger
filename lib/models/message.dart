import 'package:image_picker/image_picker.dart';

class Message {
  bool isFromOtherUser;
  String text;
  DateTime dateDelivered;
  bool isReaded;
  XFile? attachedImg;

  Message(
      {required this.isFromOtherUser,
      required this.text,
      required this.dateDelivered,
      required this.isReaded,
      this.attachedImg});
}
