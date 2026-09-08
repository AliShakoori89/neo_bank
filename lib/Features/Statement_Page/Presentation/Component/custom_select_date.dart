import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Theme/app_colors.dart';
import 'convert_time_format.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.timeFormKey,
    required this.timeController,
    this.pageName,
    this.value,
    this.isSwitch,
  });

  final GlobalKey<FormState> timeFormKey;
  final TextEditingController timeController;
  final String? pageName;
  final String? value;
  final bool? isSwitch;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  Jalali? selectedDate;

  @override
  void initState() {
    super.initState();
    // اگر value از قبل داده شده، TextController را پر کن
    if (widget.value != null && widget.value!.isNotEmpty) {
      widget.timeController.text = changeTimeFormat(widget.value!).toPersianDigit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      child: Form(
        key: widget.timeFormKey,
        child: TextFormField(
          enabled: widget.isSwitch == true &&
              (widget.value == null || widget.value!.isEmpty)
              ? true
              : widget.isSwitch != null && widget.isSwitch == true
              ? false
              : true,
          controller: widget.timeController,
          readOnly: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            hintText: 'لطفاً تاریخ را وارد کنید',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لطفاً تاریخ مورد نظر را وارد کنید';
            }
            return null;
          },
          onTap: () async {
            Jalali? picked = await showPersianDatePicker(
              context: context,
              initialDate: selectedDate ?? Jalali.now(),
              firstDate: Jalali(1360, 1),
              lastDate: Jalali(1450, 12),
              initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
              initialDatePickerMode: PersianDatePickerMode.day,
                builder: (context, child) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;

                  return Theme(
                    data: ThemeData(
                      brightness: isDark ? Brightness.dark : Brightness.light,
                      colorScheme: isDark
                          ? const ColorScheme.dark(
                        primary: AppColors.splashGradiantColor1, // 🟢 رنگ روز انتخاب‌شده
                        onPrimary: Colors.black,     // رنگ متن روز انتخاب‌شده
                        surface: Color(0xff1E1E1E),  // بک‌گراند دیالوگ
                        onSurface: Colors.white,     // متن‌ها
                      )
                          : const ColorScheme.light(
                        primary: AppColors.splashGradiantColor1, // 🔵 رنگ روز انتخاب‌شده
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor:
                          isDark ? AppColors.splashGradiantColor1 : AppColors.splashGradiantColor1,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
            );

            if (picked != null) {
              setState(() {
                selectedDate = picked;
                final formatted =
                    '${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}';
                widget.timeController.text = formatted.toPersianDigit();
              });
            }
          },
        ),
      ),
    );
  }
}
