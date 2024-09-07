import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:town_pass/util/tp_track_location.dart';
import 'package:town_pass/util/tp_web_view.dart';
import 'package:town_pass/util/web_message_handler/tp_web_message_listener.dart';
import 'package:town_pass/util/web_message_handler/tp_web_message_reply.dart';

class HomeViewController extends GetxController {
  StreamSubscription<Position>? streamLocation;

  @override
  void onInit() {
    super.onInit();
    trackUserLocation();
  }

  void trackUserLocation(){
    streamLocation = TPTrackLocation.getLocationStream().listen((position) async {

    });

    streamLocation?.onError((e){
      e.printError();
    });
  }

  WebMessage replyWebMessage(String name, {required Object? data}) {
    return TPWebStringMessageReply(
      name: name,
      data: data,
    ).message;
  }

  @override
  void onClose() {
    streamLocation?.cancel();
    super.onClose();
  }
}
