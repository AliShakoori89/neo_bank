import 'package:flutter/material.dart';
import '../../../custom_header.dart';


class InternetPackagesPage extends StatefulWidget {
  const InternetPackagesPage({super.key, required selectedOperator, required phoneNumber});

  @override
  State<InternetPackagesPage> createState() => _InternetPackagesPageState();
}

class _InternetPackagesPageState extends State<InternetPackagesPage> {

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            CustomHeader(title: 'انتخاب بسته اینترنت'),
          ],
        ),
      ),
    );
  }
}




