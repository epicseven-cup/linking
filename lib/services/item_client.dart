import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../repo/item.dart';
class ItemClient {
  send(List<String> addresses, Item data){
    for (var i = 0; i < addresses.length; i++){
      log(addresses[i]);
      final channel = WebSocketChannel.connect(Uri.parse(addresses[i]));
      channel.sink.add(jsonEncode(data.toJson()));
      channel.sink.close();
    }
  }
}