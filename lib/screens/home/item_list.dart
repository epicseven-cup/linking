import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:linking/repo/item.dart';
import 'package:linking/services/linking_service.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:shelf/shelf_io.dart' as shelf_io;
import '../../component/share_item.dart';

class ItemList extends StatefulWidget {

  const ItemList({super.key, required this.cb});

  final ValueGetter<List<ShareItem>> cb;

  @override
  State<StatefulWidget> createState() => _ItemListState();


}


class _ItemListState extends State<ItemList> {


  List<ShareItem> items = [];

  @override
  void initState() {
    super.initState();

    log('Updating Items');
    _startWebSocketServer();
  }


  void _startWebSocketServer() async {
    var handler = webSocketHandler((webSocket, _) {
      log('hello');
      setState(() {
        log('Hello world');
        items.add(ShareItem(title: 'test', content:'test'));
      });

    });

    final server = await shelf_io.serve(handler, '0.0.0.0', 3000);
    log("The server is up");
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text('Item List'),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  border: Border.all(
                    width: 2.0,
                    color: Theme
                        .of(context)
                        .dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ListView.builder(itemCount: items.length,
                        itemBuilder: (BuildContext build, int index) {
                          return items[index];
                        })
                )
            ),
          ),
        ],
      ),
    );
  }

}