import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linking/component/share_item.dart';
import 'package:linking/repo/item.dart';

import '../services/item_client.dart';

class UploadFile extends StatefulWidget {
  final List<String> addresses;

  const UploadFile({super.key, required this.addresses});

  @override
  State<StatefulWidget> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final _client = ItemClient();

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    log('hit');
    if (result != null) {
      log('hit22');
      File file = File(result.files.single.path!);
      log(base64Encode(file.readAsBytesSync()));
      _client.send(
        widget.addresses,
        Item(type: 1, clipboard: '', attachment: base64Encode(file.readAsBytesSync())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text('Click the icon to upload file'),
          IconButton(
            onPressed: () {
              _pickFiles();
            },
            icon: Icon(Icons.attach_file),
          ),
        ],
      ),
    );
  }
}
