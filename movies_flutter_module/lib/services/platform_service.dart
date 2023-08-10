import 'package:flutter/services.dart';

class PlatformService {
  static const platform = MethodChannel('OPEN');
  static const stream = EventChannel('MOVIES');

  Future<String?> openMovieDetails(String name) async {
    try {
      return await platform.invokeMethod<String>('CALL', {"NAME": name});
    } on PlatformException catch (e) {
      print("Failed to get value: '${e.message}'.");
      return '';
    }
  }

  Stream<String> getStream() => stream.receiveBroadcastStream().map((event) => event as String);
}
