import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Widgets/neo_bank_logo.dart';
import '../../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';

class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            /// --- Header ---
            CustomHeader(title: 'درباره برنامه', hasBackArrow: true,),
            AppSpace.heightSpace_24,
            NeoBankLogo(
                width: 300,
                height: 300,
                logoHeight: 150,
                logoWidth: 150,
                space: 10,
                logoColor: theme.colorScheme.primaryFixed),
            Spacer(),
            Text('نسخه ${'5.2.1245'.toPersianDigit()}',style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.surface,
            ),),
            AppSpace.heightSpace_42
          ],
        )
      ),
    );
  }
}
