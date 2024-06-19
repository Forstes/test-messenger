import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/models/message.dart';
import 'package:messenger/widgets/image_uploaded_modal.dart';

class BottomChatPanel extends StatelessWidget {
  BottomChatPanel({super.key, required this.onSendMessage, required this.contactId});

  final ImagePicker _picker = ImagePicker();
  final Function(Message) onSendMessage;
  final TextEditingController _contoller = TextEditingController();
  final int contactId;

  void _sendMsg() {
    if (_contoller.text.isEmpty) return;

    final Message msg = Message(
        isFromOtherUser: false,
        text: _contoller.text.trim(),
        dateDelivered: DateTime.now(),
        isReaded: true,
        contactId: contactId);
    onSendMessage(msg);

    _contoller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton.filled(
          onPressed: () async {
            final imgs = await _picker.pickMultiImage();
            if (imgs.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) => ImageUploadedModal(
                        image: imgs[0],
                        onSubmit: (v) {
                          onSendMessage(Message(
                              isFromOtherUser: false,
                              contactId: contactId,
                              text: v.text,
                              dateDelivered: DateTime.now(),
                              attachedImg: v.image,
                              isReaded: false));
                        },
                      ));
            }
          },
          icon: const Icon(Icons.attach_file, size: 28, color: Color(0xFF2B333E)),
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Color(0xFFEDF2F6)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: _contoller,
              decoration: InputDecoration(
                fillColor: const Color(0xFFEDF2F6),
                filled: true,
                hintText: 'Сообщение',
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: _sendMsg,
                  icon: const Icon(Icons.send),
                ),
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton.filled(
          onPressed: () {},
          icon: const Icon(Icons.mic_none, size: 30, color: Color(0xFF2B333E)),
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Color(0xFFEDF2F6)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
