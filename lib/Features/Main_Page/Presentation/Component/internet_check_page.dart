import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/check_internet.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

class InternetCheckPage extends StatefulWidget {
  final Widget child;

  const InternetCheckPage({super.key, required this.child});

  @override
  State<InternetCheckPage> createState() => _InternetCheckPageState();
}

class _InternetCheckPageState extends State<InternetCheckPage> {
  bool? hasInternet;
  bool isChecking = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    setState(() => isChecking = true);
    final result = await NetworkUtils.hasInternet();
    setState(() {
      hasInternet = result;
      isChecking = false;
    });
  }

  Future<bool> isVpnActive() async {
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final country = data['country_name'];
        final org = data['org']; // بعضی وقت‌ها نام VPN در org است
        print('Country: $country, Org: $org');

        // شرط ساده: اگر org شامل VPN بود
        if (org != null && org.toLowerCase().contains('vpn')) {
          return true;
        }
      }
    } catch (_) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (hasInternet == true) {
      return widget.child;
    }

    // صفحه اینترنت قطع
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme == AppTheme.lightTheme
                    ? [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ]
                    : [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 80, color: Colors.red),
                    const SizedBox(height: 20),
                    const Text(
                      'اتصال اینترنت برقرار نیست',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _checkConnection,
                      child: const Text('سعی مجدد'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
