import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/stack_circle.dart';
import '../../../../Core/Const/app_colors.dart';
import 'find_bank_name.dart'; // شامل Map بانک‌ها

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final StreamController<String> _bankStreamController =
      StreamController<String>.broadcast();
  Stream<String> get bankStream => _bankStreamController.stream;

  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;

  late String bankName = '';
  late String digitsOnly = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });

    // تشخیص بانک
    digitsOnly = cardNumber.replaceAll(' ', '');
    if (digitsOnly.length >= 6) {
      final bin = digitsOnly.substring(0, 6);
      bankName = iranianBanksBin[bin] ?? 'ناشناخته';
      _bankStreamController.sink.add(bankName);
    } else {
      print('111111111111111111');
      if (digitsOnly == '603799') {
        _bankStreamController.sink.add('');
        bankName = 'بانک ملی ایران';
      } else if (digitsOnly == '610433') {
        _bankStreamController.sink.add('');
        bankName = 'بانک ملت';
      }
    }
  }

  final cardNumberFormKey = GlobalKey<FormFieldState<String>>();
  final ccvNumberFormKey = GlobalKey<FormFieldState<String>>();
  final expiryDateFormKey = GlobalKey<FormFieldState<String>>();

  @override
  void dispose() {
    _bankStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: GestureDetector(
          onTap: _onValidate,
          child: Container(
            height: 50,
            margin: EdgeInsets.only(left: 40),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'اضافه کردن',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            StackCircle(
              circleColor: Theme.of(context).primaryColor,
              topPosition: -40,
              width: 500,
              height: 500,
            ),
            StackCircle(
              circleColor: Theme.of(context).primaryColor,
              topPosition: 300,
              leftPosition: -30,
              width: 400,
              height: 400,
            ),
            StackCircle(
              circleColor: Theme.of(context).primaryColor,
              topPosition: 600,
              leftPosition: 200,
              width: 300,
              height: 300,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueGrey[800],
                      image: DecorationImage(
                        image: AssetImage(
                          bankName == '' || digitsOnly.length < 6
                              ? Theme.of(context).brightness == Brightness.dark
                                    ? "assets/image/bg-dark.png"
                                    : "assets/image/bg-light.png"
                              : "assets/image/Bank_Card/bank_mehr.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 110,
                        left: 80,
                        bottom: 40,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              cardNumber.isEmpty
                                  ? "XXXX XXXX XXXX XXXX"
                                  : cardNumber,
                              style: TextStyle(
                                color: cardNumber.isEmpty
                                    ? Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white
                                    : Theme.of(context).brightness ==
                                          Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 18,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                expiryDate.isEmpty ? "MM/YY" : expiryDate,
                                style: TextStyle(
                                  color: expiryDate.isEmpty
                                      ? Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white
                                      : Theme.of(context).brightness ==
                                            Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: false,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          cardNumberKey: cardNumberFormKey,
                          cvvCodeKey: ccvNumberFormKey,
                          expiryDateKey: expiryDateFormKey,
                          numberValidationMessage: 'پر کردن این فیلد اجباریست.',
                          cvvValidationMessage: 'پر کردن این فیلد اجباریست.',
                          dateValidationMessage: 'پر کردن این فیلد اجباریست.',
                          inputConfiguration: InputConfiguration(
                            expiryDateTextStyle: TextStyle(color: Colors.black),
                            cardNumberTextStyle: TextStyle(color: Colors.black),
                            cvvCodeTextStyle: TextStyle(color: Colors.black),
                            cardNumberDecoration: InputDecoration(
                              labelText: 'شماره کارت',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'XXXX XXXX XXXX XXXX',
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              hintTextDirection: TextDirection.ltr,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            expiryDateDecoration: InputDecoration(
                              labelText: 'تاریخ انقضا',
                              hintText: 'XX/XX',
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              hintTextDirection: TextDirection.ltr,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            cvvCodeDecoration: InputDecoration(
                              labelText: 'CVV',
                              hintText: 'XXXX',
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              hintTextDirection: TextDirection.ltr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        // StreamBuilder برای نمایش نام بانک
                        StreamBuilder<String>(
                          stream: bankStream,
                          builder: (context, snapshot) {
                            final bankName = snapshot.data ?? '';
                            if (bankName.isEmpty)
                              return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'بانک: $bankName',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
