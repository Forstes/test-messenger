import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/models/message.dart';
import 'package:messenger/widgets/image_uploaded_modal.dart';

class BottomChatPanel extends StatelessWidget {
  BottomChatPanel({super.key, required this.onSendMessage});

  final ImagePicker _picker = ImagePicker();
  final Function(Message) onSendMessage;
  final TextEditingController _contoller = TextEditingController();

  void _sendMsg() {
    if (_contoller.text.isEmpty) return;

    final Message msg =
        Message(isFromOtherUser: false, text: _contoller.text.trim(), dateDelivered: DateTime.now(), isReaded: true);
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
                              text: v.text,
                              dateDelivered: DateTime.now(),
                              attachedImg: v.image,
                              isReaded: false));
                        },
                      ));
            }
          },
          icon: const Icon(Icons.file_copy, size: 30),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: _contoller,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade300,
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
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
        ),
        const SizedBox(width: 16),
        IconButton.filled(
          onPressed: () {},
          icon: const Icon(Icons.mic, size: 30),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
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
