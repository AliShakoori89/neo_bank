import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Data/Model/profile_model.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class NameAndPhone extends StatelessWidget {
  const NameAndPhone({super.key, required this.profileDetail});

  final ProfileModel profileDetail;

  @override
  Widget build(BuildContext context) {
    return profileDetail.data != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileDetail.data!.name!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
              AppSpace.heightSpace_12,
              Text(
                profileDetail.data!.mobile!.toPersianDigit(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          )
        : Text('');
  }
}
