import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linking/component/device_item.dart';
import 'package:linking/services/item_client.dart';

import '../repo/item.dart';

class UploadText extends StatefulWidget {
  const UploadText({super.key, required this.address});

  final List<String> address;

  @override
  State<StatefulWidget> createState() => _UploadTextState();
}

class _UploadTextState extends State<UploadText> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _client = ItemClient();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'clipboard text',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _client.send(widget.address, Item(type: 0 , clipboard: _controller.text, attachment: ''));
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
