import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Widgets/to_persian_number.dart';

const List<String> list = <String>[
  '500570005633843001',
  '500570005633843002',
  '500570005633843003',
  '500570005633843004',
];

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String dropdownValue = list.first;

  late final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>(
      (String name) => MenuEntry(
        value: name,
        label: toPersianNumber(name), // اعداد فارسی اینجا قرار می‌گیرن
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.surfaceDim, // inner border مشابه CSS
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(10, 13, 18, 0.05),
            offset: Offset(0, -2),
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(10, 13, 18, 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color.fromRGBO(10, 13, 18, 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width - 60,
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
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8),
          //   borderSide: BorderSide(
          //     color: Theme.of(context).colorScheme.surfaceDim,
          //   ),
          // ),
        ),
        initialSelection: dropdownValue,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: menuEntries,
      ),
    );
  }
}
