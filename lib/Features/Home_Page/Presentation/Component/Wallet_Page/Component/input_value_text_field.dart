import 'package:flutter/material.dart';
import '../../../../../../Core/Spacing/app_space.dart';
import 'add_balance_text_field.dart';
import 'custom_formatter.dart';
import 'number_to_words.dart';

class InputValueTextField extends StatefulWidget {
  const InputValueTextField({
    super.key,
    required this.balanceController,
    required this.balanceFormKey,
    this.onAmountChanged
  });

  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;
  final Function(int)? onAmountChanged;

  @override
  State<InputValueTextField> createState() => _InputValueTextFieldState();
}

class _InputValueTextFieldState extends State<InputValueTextField> {
  String _amountInWords = '';

  @override
  void initState() {
    super.initState();
    // اضافه کردن listener برای监听 تغییرات متن
    widget.balanceController.addListener(_onTextChanged);
    // مقدار اولیه
    _updateAmountInWords();
  }

  @override
  void dispose() {
    widget.balanceController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    _updateAmountInWords();
    // اطلاع به والد
    widget.onAmountChanged?.call(widget.balanceController.rawValue);
  }

  void _updateAmountInWords() {
    final rawValue = widget.balanceController.rawValue;
    setState(() {
      _amountInWords = NumberToWords.convert(rawValue);
    });
  }

  void _updateAmount(int newValue) {
    widget.balanceController.text = newValue.toString();
    // نیازی به فراخوانی دستی setState نیست چون listener انجام می‌دهد
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  int current = widget.balanceController.rawValue;
                  current -= 10000;
                  if (current < 0) current = 0;
                  _updateAmount(current);
                },
                icon: const Icon(Icons.remove),
              ),
            ),
            AppSpace.widthSpace_8,
            Expanded(
              child: AddBalanceTextField(
                balanceController: widget.balanceController,
                balanceFormKey: widget.balanceFormKey,
                onChanged: (value) {
                  // listener کار به‌روزرسانی را انجام می‌دهد
                  // فقط والد را مطلع می‌کنیم
                  widget.onAmountChanged?.call(widget.balanceController.rawValue);
                },
              ),
            ),
            AppSpace.widthSpace_8,
            Container(
              width: 50,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  int current = widget.balanceController.rawValue;
                  current += 10000;
                  _updateAmount(current);
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        // نمایش مبلغ به حروف
        if (_amountInWords.isNotEmpty && _amountInWords != 'صفر تومان') ...[
          AppSpace.heightSpace_8,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.edit_note, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _amountInWords,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}