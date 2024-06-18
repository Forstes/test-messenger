import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/widgets/image_rounded.dart';

class ImageWithText {
  String text;
  XFile image;

  ImageWithText({required this.image, required this.text});
}

class ImageUploadedModal extends StatelessWidget {
  const ImageUploadedModal({super.key, required this.image, required this.onSubmit});

  final XFile image;
  final Function(ImageWithText) onSubmit;

  @override
  Widget build(BuildContext context) {
    ImageWithText objToSubmit = ImageWithText(image: image, text: "");

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            ImageRounded(image: image, width: 280, height: 150),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) => objToSubmit.text = value,
              decoration: const InputDecoration(
                labelText: 'Сообщение',
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            onSubmit(objToSubmit);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
