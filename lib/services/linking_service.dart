import 'dart:developer';
import 'dart:io';

import 'package:multicast_dns/multicast_dns.dart';
import 'package:nsd/nsd.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class LinkingService {
  // final String name = '_linking-service._tcp.local';
  final String name = '_linking._tcp';

  Future<void> registerService() async {
    final service = Service(
      name: 'Linking Service',
      type: '_linking._tcp',
      port: 3000,
    );
    final registration = await register(service);
    log('Service registered');
  }

  Future<List<(SrvResourceRecord, String)>> discover() async {
    final MDnsClient client = MDnsClient();
    await client.start();

    final List<(SrvResourceRecord, String)> devices = [];

    await for (final PtrResourceRecord ptr in client.lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))){
      await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
      ResourceRecordQuery.service(ptr.domainName))){
        final String bundleId = ptr.domainName;
        log('Dart find ${srv.target}:${srv.port} for ${bundleId}.');

        await for (final IPAddressResourceRecord ip
        in client.lookup<IPAddressResourceRecord>(
            ResourceRecordQuery.addressIPv4(srv.target))) {
          print('IP: ${ip.address.toString()}');

          devices.add((srv, ip.address.address));
        }
      }



    }
    log('Done. Total Device found ${devices.length}');
    client.stop();
    return devices;
  }

}