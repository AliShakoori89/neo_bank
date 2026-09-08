import 'package:flutter/material.dart';
import '../../../../Core/Widgets/to_persian_number.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class StatementDropdownButton extends StatefulWidget {
  const StatementDropdownButton({
    super.key,
    required this.cardsDeposit,
    this.onChanged,
    required this.selectedValue,
  });

  final List<String> cardsDeposit;
  final ValueChanged<String>? onChanged;
  final String selectedValue;

  @override
  State<StatementDropdownButton> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<StatementDropdownButton> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant StatementDropdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      dropdownValue = widget.selectedValue;
    }
  }

  List<MenuEntry> get menuEntries => widget.cardsDeposit
      .map((card) => MenuEntry(value: card, label: toPersianNumber(card)))
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceDim,
          width: 1,
        ),
      ),
      child: DropdownMenu<String>(
        textAlign: TextAlign.center,
        trailingIcon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: Theme.of(context).colorScheme.onPrimary,
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
        ),
        initialSelection: dropdownValue,
        onSelected: (value) {
          if (value == null) return;
          setState(() => dropdownValue = value);
          widget.onChanged?.call(value);
        },
        dropdownMenuEntries: menuEntries,
      ),
    );
  }
}
