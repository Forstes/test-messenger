import 'package:flutter/material.dart';

class BottomChatPanel extends StatelessWidget {
  const BottomChatPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton.filled(
          onPressed: () {},
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
