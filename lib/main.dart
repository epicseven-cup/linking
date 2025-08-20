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
  runApp(const Linking());
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
                  ItemList(),
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
