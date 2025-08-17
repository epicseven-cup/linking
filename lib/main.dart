import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:linking/repo/item.dart';
import 'package:linking/screens/home/device_list.dart';
import 'package:linking/screens/home/item_list.dart';
import 'package:linking/screens/home/mobile_home.dart';
import 'package:linking/theme/theme.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

import 'component/share_item.dart';

void main() {
  // _background_service();
  runApp(const Linking());
}

List<ShareItem> si = [];

// sendport is used to pass the data back to main thread, but in this case I already have a websocket client setup it is not needed
Future<void> _startWebSocketServer(SendPort send) async {
  var handler = webSocketHandler((webSocket, _) {
    webSocket.stream.listen((message) {
      send.send(message);
    });
  });

  await shelf_io.serve(handler, '0.0.0.0', 3000);
  log("The server si up");
}

void _background_service() async {
  final rp = ReceivePort();
  await Isolate.spawn(_startWebSocketServer, rp.sendPort);
  rp.listen((data) {
    log(data);
    log(si.length.toString());
    Item dItem = Item.fromJson(jsonDecode(data));
    if (dItem.type == 0) {
      si.add(ShareItem(title: dItem.clipboard, content: dItem.clipboard));
    } else {
      si.add(ShareItem(title: 'File', content: dItem.attachment));
    }
  });
}

List<ShareItem> cb() {
  return si;
}

class Linking extends StatelessWidget {
  const Linking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linking',
      theme: ThemeData(colorScheme: darkColorScheme),
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          // if (constraint.maxWidth > 600){
          //   return SafeArea(child: HomeScreen());
          // } else {
          return SafeArea(
            child: Material(
              child: Column(
                spacing: 50,
                children: [
                  DeviceList(),
                  ItemList(cb: cb),
                ],
              ),
            ),
          );
          // }
        },
      ),
    );
  }
}
