import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linking/component/upload_file.dart';
import 'package:linking/services/linking_service.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../component/device_item.dart';
import '../../component/upload_text.dart';

class DeviceList extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  late LinkingService ls;
  List<(SrvResourceRecord, String)> devices = [];
  List<bool> selectedDevice = [];

  Future<void> _asyncLoading() async {
    List<(SrvResourceRecord, String)> ds = await ls.discover();

    selectedDevice = List.filled(ds.length, false);

    setState(() {
      devices = ds;
    });
  }


  void checkDevice(SelectPair v) {
    setState(() {
      selectedDevice[v.index] = v.check;
    });
  }

  List<String> _getAddresses(){
    late List <String> address = [];
    for (var i = 0; i < selectedDevice.length; i++) {
      if (selectedDevice[i]) {
        String addr = 'ws://${devices[i].$2}:${devices[i].$1.port}';
        log(addr);
        address.add(addr);
      }
    }
    return address;
  }


  @override
  void initState() {
    super.initState();
    ls = LinkingService();

    // sign me up
    ls.registerService();

    _asyncLoading();

    // discovering new devices
    Timer.periodic(new Duration(seconds: 5), (time) {
      log('Updating discovering device');
      _asyncLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text('Device List', textAlign: TextAlign.left),
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
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DeviceItem(name: devices[index].$1.target,
                      cb: checkDevice,
                      index: index,);
                  },
                ),
              ),
            ),
          ),

          Row(
            children: [
              TextButton(onPressed: () {
                showDialog(context: context,
                    builder: (context) {
                      return UploadText(address: _getAddresses());
                    }
                );
              }, child: Text('Send Text')),
              TextButton(onPressed: () {
                showDialog(context: context,
                    builder: (context) {
                      return UploadFile(addresses: _getAddresses());
                    }
                );
              }, child: Text('Send File')),
            ],
          ),
        ],
      ),
    );
  }
}
