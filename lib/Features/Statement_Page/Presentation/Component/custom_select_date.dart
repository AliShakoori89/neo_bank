import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../Core/Const/app_colors.dart';
import 'convert_time_format.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({super.key, required this.timeFormKey, required this.timeController, this.pageName,
    this.value, this.isSwitch});

  final GlobalKey<FormState> timeFormKey;
  final TextEditingController timeController;
  String? pageName;
  String? value;
  bool? isSwitch;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {

  String localLabel = 'انتخاب تاریخ زمان';
  Jalali? selectedDate;

  @override
  Widget build(BuildContext context) {

    if (widget.value != null && widget.value!.isNotEmpty && widget.timeController.text.isEmpty) {

      String formatted = changeTimeFormat(widget.value!);

      widget.timeController.text = formatted;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      child: Form(
        key: widget.timeFormKey,
        child: TextFormField(
          enabled: widget.isSwitch == true && (widget.value == null || widget.value!.isEmpty)
              ? true
              : widget.isSwitch != null && widget.isSwitch == true
              ? false
              : true,
          onTap: () async {
            Jalali? picked = await showPersianDatePicker(
              context: context,
              initialDate: Jalali.now(),
              firstDate: Jalali(1360, 8),
              lastDate: Jalali(1450, 9),
              initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
              initialDatePickerMode: PersianDatePickerMode.year,
            );
            if (picked != null) {
              setState(() {
                selectedDate = picked;
                final formatted = '${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}';
                widget.timeController.text = formatted.toPersianDigit();

              });
            }
          },
          controller: widget.timeController,
          readOnly: true,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixed,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintText: 'لطفاً تاریخ را وارد کنید',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryFixed,),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryFixed,),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryFixed,),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لطفاً تاریخ مورد نظر را وارد کنید';
            }
            return null;
          },
        ),
      ),
    );
  }
}