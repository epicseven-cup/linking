
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


sealed class Content<T> {

}


class ShareItem extends StatefulWidget {

  const ShareItem({super.key, required this.title, required this.content});
  final String title;
  final dynamic content;

  @override
  State<StatefulWidget> createState() => _ShareItemState();
}

class _ShareItemState  extends State<ShareItem>{


  @override
  Widget build(BuildContext context){
    return ListTileTheme(child:
    ListTile(
      title: Text(widget.title),
      trailing: Icon(Icons.more_vert),
    ));
  }
}