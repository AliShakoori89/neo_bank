import 'package:flutter/material.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../statement_page.dart';


class SelectTransactionTypes extends StatefulWidget {
  const SelectTransactionTypes({super.key,
    required this.selectedType,
    required this.onCompleted});

  final TransactionType selectedType;
  final Function(TransactionType) onCompleted;

  @override
  State<SelectTransactionTypes> createState() => _SelectTransactionTypesState();
}

class _SelectTransactionTypesState extends State<SelectTransactionTypes> {



  String _label(TransactionType type) {
    switch (type) {
      case TransactionType.deposit:
        return 'واریز';
      case TransactionType.withdraw:
        return 'برداشت';
      case TransactionType.all:
        return 'همه';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نوع تراکنش',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpace.heightSpace_12,

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: TransactionType.values.map((type) {

              final isSelected = widget.selectedType == type;

              return Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    right: type == TransactionType.all
                        ? const Radius.circular(10)
                        : Radius.zero,
                    left: type == TransactionType.withdraw
                        ? const Radius.circular(10)
                        : Radius.zero,
                  ),
                  child: Material(
                    color: isSelected
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.onInverseSurface,
                    child: InkWell(
                      onTap: () {
                        widget.onCompleted(type);
                      },
                      splashColor: Colors.white24,
                      highlightColor: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _label(type),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
