import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker_plus/flutter_native_contact_picker_plus.dart';
import 'package:flutter_native_contact_picker_plus/model/contact_model.dart';

import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/convert_phonenumber.dart';
import '../Theme/app_colors.dart';

class ContactPhoneNumberPicker extends StatefulWidget {
  ContactPhoneNumberPicker({super.key, required this.phoneNumberController, required this.phoneNumberFormKey, required this.contactPicker, this.contacts});

  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> phoneNumberFormKey;
  final FlutterContactPickerPlus contactPicker;
  List<Contact>? contacts;

  @override
  State<ContactPhoneNumberPicker> createState() => _ContactPhoneNumberPickerState();
}

class _ContactPhoneNumberPickerState extends State<ContactPhoneNumberPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () async{
              Contact? contact = await widget.contactPicker.selectContact();
              setState(() {
                widget.contacts = contact == null ? null : [contact];
                widget.phoneNumberController.text = convertPhoneNumber(widget.contacts!.first.phoneNumbers![0].toString());
              });
            },
            icon: Icon(Icons.contacts_rounded, color: AppColors.splashGradiantColor2,),
          ),
        ),
        Expanded(
          flex: 9,
          child: Form(
            key: widget.phoneNumberFormKey,
            child: TextFormField(
              textDirection: TextDirection.ltr,
              controller: widget.phoneNumberController,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              obscureText: false,
              style: TextStyle(
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا شماره همراه خود را وارد نمایید.';
                }
                if (value.length != 11) {
                  return 'شماره همراه وارد شده صحیح نمی باشد.';
                }
                if (value.startsWith('09') == false) {
                  return 'شماره همراه وارد شده صحیح نمی باشد.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '09XXXXXXXXX',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                ),
                hintTextDirection: TextDirection.ltr,
                contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                // تنظیم پدینگ عمودی
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.splashGradiantColor2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
