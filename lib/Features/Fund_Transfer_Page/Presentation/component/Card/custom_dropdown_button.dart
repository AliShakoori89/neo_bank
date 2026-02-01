import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/to_persian_number.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key, required this.cardsPan});

  final List<String> cardsPan;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownButton> {
  late String dropdownValue = widget.cardsPan.first;

  late final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    widget.cardsPan.map<MenuEntry>(
      (String card) => MenuEntry(value: card, label: toPersianNumber(card)),
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
          color: Theme.of(context).colorScheme.surfaceDim,
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
