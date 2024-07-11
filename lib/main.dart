import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deviceInfo = 'Press the button to get device information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info Check'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Get Device Information"),
              onPressed: () async {
                var device = DeviceInfoPlugin();
                String info = '';

                // Check user's device information
                if (Platform.isAndroid) {
                  var androidInfo = await device.androidInfo;
                  info = 'Device: ${androidInfo.model}\n'
                      'Manufacturer: ${androidInfo.manufacturer}\n'
                      'Android Version: ${androidInfo.version.release}\n'
                      'SDK: ${androidInfo.version.sdkInt}\n'
                      'Brand: ${androidInfo.brand}\n';
                      // 'Device ID: ${androidInfo.androidId}\n';
                } else if (Platform.isIOS) {
                  var iosInfo = await device.iosInfo;
                  info = 'Device: ${iosInfo.name}\n'
                      'System Name: ${iosInfo.systemName}\n'
                      'System Version: ${iosInfo.systemVersion}\n'
                      'Model: ${iosInfo.model}\n'
                      'Identifier: ${iosInfo.identifierForVendor}\n';
                }

                setState(() {
                  deviceInfo = info;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              deviceInfo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
