// ignore_for_file: file_names, unused_field, missing_return, body_might_complete_normally_nullable

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  Future<bool> checkNetworkOnce() async {
    dynamic result = await _connectivity.checkConnectivity();
    dynamic checkInitResult = updateConnectivity(result);
    try {
      if (checkInitResult == 0) {
        return false;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  List<ConnectivityResult> resultData = [];

  Future<void> initConnectivity() async {
    try {
      resultData = await _connectivity.checkConnectivity();
    } catch (e) {
      log(e.toString());
    }
    return updateConnectivity(resultData);
  }

  updateConnectivity(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.mobile:
        return true; // if connected with wifi status set 1

      case ConnectivityResult.wifi:
        return true; // if connected with wifi status set 2

      case ConnectivityResult.none:
        return false;

      default:
    }
  }
}
