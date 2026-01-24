import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Network/Check_Connection_Bloc/check_connection_event.dart';
import '../Network/Check_Connection_Bloc/check_connection_bloc.dart';
import 'package:http/http.dart' as http;

Future<bool> checkInternet() async {
  // بررسی اینترنت واقعی
  try {
    final result = await http
        .get(Uri.parse('https://google.com'))
        .timeout(const Duration(seconds: 5));
    return result.statusCode == 200;
  } catch (_) {
    return false;
  }
}

void listenConnectivity(BuildContext context) {
  Connectivity().onConnectivityChanged.listen((result) async {
    bool isOnline = false;

    if (result != ConnectivityResult.none) {
      // برای اطمینان از اتصال واقعی اینترنت
      isOnline = await checkInternet();
    }

    context.read<ConnectivityBloc>().add(ConnectivityChangedEvent(isOnline));
  });
}
