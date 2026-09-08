import 'dart:collection';
import 'package:flutter/material.dart';

import '../../../../../Core/Theme/app_colors.dart';
import '../../../../../Core/Widgets/to_persian_number.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.cardsPan,
    this.widthSize,
    this.heightSize,
    this.onChanged,  // ✅ اضافه کردن onChanged
  });

  final List<String> cardsPan;
  final double? widthSize;
  final double? heightSize;
  final Function(String)? onChanged;  // ✅ اضافه کردن callback

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownButton> {
  late String dropdownValue;

  late final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    widget.cardsPan.map<MenuEntry>(
          (String card) => MenuEntry(value: card, label: toPersianNumber(card)),
    ),
  );

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.cardsPan.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthSize ?? MediaQuery.of(context).size.width - 60,
      height: widget.heightSize ?? 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceDim,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(10, 13, 18, 0.05),
            offset: const Offset(0, -2),
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color.fromRGBO(10, 13, 18, 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: const Color.fromRGBO(10, 13, 18, 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: DropdownMenu<String>(
          width: widget.widthSize != null
              ? MediaQuery.of(context).size.width - 83
              : MediaQuery.of(context).size.width - 60,
          textAlign: TextAlign.center,
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: AppColors.loginPageIconColor,
            size: 20,
          ),
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_up_sharp,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            size: 20,
          ),
          textStyle: TextStyle(color: Theme.of(context).colorScheme.primaryFixed),
          inputDecorationTheme: InputDecorationTheme(
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints.tight(Size.fromHeight(40)),
          ),
          initialSelection: dropdownValue,
          onSelected: (String? value) {
            if (value != null) {
              setState(() {
                dropdownValue = value;
              });
              widget.onChanged?.call(value);  // ✅ فراخوانی callback
            }
          },
          dropdownMenuEntries: menuEntries,
        ),
      ),
    );
  }
}