import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});



  @override
  State<StatefulWidget> createState() => _UploadFileState();
}



class _UploadFileState extends State<UploadFile> {


  final _formKey = GlobalKey<FormState>();


  void _pickFiles() async {
    bool hasUserAborted = true;
    
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      content: Form(key: _formKey, child: Column(
        children: [
          Icon(Icons.attach_file),
          TextButton(onPressed: () {

          }, child: Text('Send'))
        ],
      ),)
    )
  }
}

