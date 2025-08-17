import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linking/component/device_item.dart';
import 'package:linking/component/share_item.dart';
import 'package:linking/screens/home/device_list.dart';
import 'package:linking/screens/home/item_list.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        spacing: 50,
        children: [
          DeviceList(),
        ],
      ),
    );
  }
}
