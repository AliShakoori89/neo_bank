import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker_plus/flutter_native_contact_picker_plus.dart';
import 'package:flutter_native_contact_picker_plus/model/contact_model.dart';
import 'package:neo_bank_mehr_iran/Core/Widgets/contact_phone_number_picker.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../custom_button.dart';

class GiftTabBody extends StatefulWidget {
  const GiftTabBody({super.key});

  @override
  State<GiftTabBody> createState() => _GiftTabBodyState();
}

class _GiftTabBodyState extends State<GiftTabBody> {

  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  final FlutterContactPickerPlus _contactPicker = FlutterContactPickerPlus();
  List<Contact>? _contacts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'شماره تلفن همراه مقصد:',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context)
                  .colorScheme
                  .primaryFixed,
            ),
          ),
          AppSpace.heightSpace_8,
          ContactPhoneNumberPicker(
              phoneNumberController: phoneNumberController,
              phoneNumberFormKey: phoneNumberFormKey,
              contactPicker: _contactPicker,
              contacts: _contacts,
          ),
          AppSpace.heightSpace_12,

          // دکمه تایید
          CustomButton(),
          AppSpace.heightSpace_42,
          Text('. با استفاده از این قابلیت میتوانید مبلغی را به همراه پیام و طرح دلخواه به عنوان هدیه به مخاطب خود انتقال دهید.',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixed
          ),),
          AppSpace.heightSpace_8,
          Text('. بعد از ارسال هدیه از طریق پیامک به مخاطب شما اطلاع رسانی شده و ایشان میتواند مبلغ هدیه خود را دریافت کند.',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryFixed
            ),)

        ],
      ),
    );
  }
}
