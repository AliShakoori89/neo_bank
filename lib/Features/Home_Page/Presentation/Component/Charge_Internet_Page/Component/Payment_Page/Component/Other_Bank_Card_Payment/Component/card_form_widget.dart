import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../../../../../Core/Spacing/app_space.dart';
import 'bank_info.dart';
import 'expire_date_formatter.dart';
import 'format_card_number.dart';
import 'luhn_validator.dart';

class CardFormWidget extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final BankInfo? detectedBank;
  final Function(String) onCardNumberChanged;
  final Map<String, BankInfo> banks;

  const CardFormWidget({
    super.key,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cvvController,
    required this.detectedBank,
    required this.onCardNumberChanged,
    required this.banks,
  });

  @override
  State<CardFormWidget> createState() => _CardFormWidgetState();
}

class _CardFormWidgetState extends State<CardFormWidget> {
  bool _obscureCvv = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اطلاعات کارت بانکی',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpace.heightSpace_24,
          _buildCardNumberField(),
          AppSpace.heightSpace_16,
          _buildExpiryAndCvvRow(),
        ],
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: widget.cardNumberController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLength: 19,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'شماره کارت',
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: 'XXXX XXXX XXXX XXXX',
        prefixIcon: const Icon(Icons.credit_card),
        suffixIcon: widget.detectedBank != null
            ? Tooltip(
          message: widget.detectedBank!.name,
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: widget.detectedBank!.color.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.detectedBank!.imageAsset != null
                ? Image.asset(
              widget.detectedBank!.imageAsset!,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            )
                : Icon(
              widget.detectedBank!.icon ?? Icons.credit_card,
              color: widget.detectedBank!.color,
              size: 24,
            ),
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        counterText: '',
      ),
      onChanged: (value) {
        CardFormatter.formatCardNumber(value, widget.cardNumberController);
        widget.onCardNumberChanged(value.replaceAll(' ', ''));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'شماره کارت را وارد کنید';
        }
        String cleaned = value.replaceAll(' ', '');
        if (cleaned.length != 16) {
          return 'شماره کارت باید 16 رقم باشد';
        }
        if (!LuhnValidator.isValid(cleaned)) {
          return 'شماره کارت معتبر نیست';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryAndCvvRow() {
    return Row(
      children: [
        Expanded(child: _buildExpiryDateField()),
        const SizedBox(width: 16),
        Expanded(child: _buildCvvField()),
      ],
    );
  }

  Widget _buildExpiryDateField() {
    return TextFormField(
      controller: widget.expiryDateController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      maxLength: 5,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'تاریخ انقضا',
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: 'MM/YY',
        prefixIcon: const Icon(Icons.date_range),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        counterText: '',
      ),
      onChanged: (value) {
        ExpiryDateFormatter.formatExpiryDate(value, widget.expiryDateController);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'تاریخ انقضا را وارد کنید';
        }
        if (value.length != 5) {
          return 'فرمت نامعتبر (MM/YY)';
        }
        List<String> parts = value.split('/');
        if (parts.length != 2) {
          return 'فرمت نامعتبر';
        }
        int month = int.tryParse(parts[0]) ?? 0;
        int year = int.tryParse(parts[1]) ?? 0;
        if (month < 1 || month > 12) {
          return 'ماه نامعتبر';
        }
        DateTime now = DateTime.now();
        int currentYear = now.year % 100;
        if (year < currentYear) {
          return 'کارت منقضی شده است';
        }
        if (year == currentYear && month < now.month) {
          return 'کارت منقضی شده است';
        }
        return null;
      },
    );
  }

  Widget _buildCvvField() {
    return TextFormField(
      controller: widget.cvvController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      obscureText: _obscureCvv,
      maxLength: 4,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      decoration: InputDecoration(
        labelText: 'CVV2',
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: 'XXX',
        prefixIcon: const Icon(Icons.security),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureCvv ? Icons.visibility_off : Icons.visibility,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscureCvv = !_obscureCvv;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        counterText: '',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'CVV را وارد کنید';
        }
        if (value.length != 3 && value.length != 4) {
          return 'CVV باید 3 یا 4 رقم باشد';
        }
        return null;
      },
    );
  }
}