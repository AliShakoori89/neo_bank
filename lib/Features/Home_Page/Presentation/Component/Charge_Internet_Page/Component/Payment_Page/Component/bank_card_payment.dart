import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../../Core/Const/app_space.dart';
import '../../../../../../Data/Model/internet_package_model.dart';
import '../../Internet_package/Package_Card_Component/get_package_color.dart';
import 'bank_info.dart';

class BankCardPayment extends StatefulWidget {
  BankCardPayment({
    super.key,
    required this.amount,
    required this.title,
    this.description,
    this.onSuccess,
    required this.package,
    this.selectedWalletTitle
  });

  final String amount;
  final String title;
  final String? description;
  final VoidCallback? onSuccess;
  final InternetPackageModel package;
  String? selectedWalletTitle;

  @override
  State<BankCardPayment> createState() => _BankCardPaymentState();
}

class _BankCardPaymentState extends State<BankCardPayment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _obscureCvv = true;
  bool _isLoading = false;
  BankInfo? _detectedBank;

  final Map<String, BankInfo> _banks = {
    '6037': BankInfo('بانک ملی ایران', 'melli', Colors.blue, imageAsset: 'assets/logo/bank_melli.png'),
    '5892': BankInfo('بانک سپه', 'sepeh', Colors.green, icon: Icons.account_balance),
    '6273': BankInfo('بانک صادرات ایران', 'saderat', Colors.red, icon: Icons.account_balance),
    '5022': BankInfo('بانک پاسارگاد', 'pasargad', Colors.purple, icon: Icons.currency_bitcoin),
    '5047': BankInfo('بانک رسالت', 'resalat', Colors.orange, icon: Icons.send),
    '6221': BankInfo('بانک ملت', 'mellat', Colors.teal, icon: Icons.people),
    '6393': BankInfo('بانک کشاورزی', 'keshavarzi', Colors.brown, icon: Icons.agriculture),
    '6274': BankInfo('بانک سامان', 'saman', Colors.indigo, icon: Icons.wb_sunny),
    '5859': BankInfo('بانک تات', 'tat', Colors.cyan, icon: Icons.link),
    '6219': BankInfo('بانک گردشگری', 'gardeshgari', Colors.pink, icon: Icons.flight),
    '6362': BankInfo('بانک انصار', 'ansar', Colors.lightBlue, icon: Icons.help),
    '6280': BankInfo('بانک توسعه صادرات', 'tedbir', Colors.deepPurple, icon: Icons.trending_up),
    '5058': BankInfo('بانک خاورمیانه', 'miyaneh', Colors.amber, icon: Icons.public),
    '5059': BankInfo('بانک سینا', 'sina', Colors.lime, icon: Icons.health_and_safety),
    '5069': BankInfo('بانک شهر', 'shahr', Colors.lightGreen, icon: Icons.location_city),
    '5072': BankInfo('بانک دی', 'dey', Colors.deepOrange, icon: Icons.calendar_today),
    '5074': BankInfo('بانک مهر اقتصاد', 'mehr', Colors.indigo, icon: Icons.attach_money),
    '5075': BankInfo('بانک حکمت ایرانیان', 'hekmat', Colors.brown, icon: Icons.school),
    '5076': BankInfo('بانک آینده', 'ayandeh', Colors.blueGrey, icon: Icons.timeline),
    '5100': BankInfo('بانک کارآفرین', 'karafarin', Colors.orangeAccent, icon: Icons.business_center),
    '5101': BankInfo('بانک پارسیان', 'parsian', Colors.redAccent, icon: Icons.work),
    '5102': BankInfo('بانک سرمایه', 'sarmayeh', Colors.greenAccent, icon: Icons.trending_up),
    '5111': BankInfo('بانک ایران زمین', 'iranzamin', Colors.purpleAccent, icon: Icons.public),
    '5120': BankInfo('بانک قوامین', 'ghavamin', Colors.cyanAccent, icon: Icons.security),
    '5128': BankInfo('بانک کوثر', 'kosar', Colors.pinkAccent, icon: Icons.favorite),
    '5140': BankInfo('بانک نور', 'noor', Colors.yellow, icon: Icons.lightbulb),
    '5165': BankInfo('بانک پست بانک', 'postbank', Colors.grey, icon: Icons.local_post_office),
    '5171': BankInfo('بانک صنعت و معدن', 'sanatmadan', Colors.brown, icon: Icons.factory),
    '5185': BankInfo('بانک توسعه تعاون', 'tedbirtaavon', Colors.lime, icon: Icons.handshake),
    '5192': BankInfo('بانک رفاه کارگران', 'refah', Colors.red, icon: Icons.work),
    '5208': BankInfo('بانک اقتصاد نوین', 'eghtesadenovin', Colors.blueGrey, icon: Icons.attach_money),
    '5272': BankInfo('بانک مسکن', 'maskan', Colors.brown, icon: Icons.home),
  };

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _detectBank(String cardNumber) {
    String cleanedNumber = cardNumber.replaceAll(' ', '');
    if (cleanedNumber.length >= 4) {
      String bin = cleanedNumber.substring(0, 4);
      if (_banks.containsKey(bin)) {
        setState(() {
          _detectedBank = _banks[bin];
        });
      } else {
        setState(() {
          _detectedBank = null;
        });
      }
    } else {
      setState(() {
        _detectedBank = null;
      });
    }
  }

  void _formatCardNumber(String value) {
    String cleaned = value.replaceAll(' ', '');
    if (cleaned.length > 16) {
      cleaned = cleaned.substring(0, 16);
    }

    List<String> parts = [];
    for (int i = 0; i < cleaned.length; i += 4) {
      int end = i + 4;
      if (end > cleaned.length) {
        end = cleaned.length;
      }
      parts.add(cleaned.substring(i, end));
    }

    String formatted = parts.join(' ');
    if (formatted != _cardNumberController.text) {
      _cardNumberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    _detectBank(cleaned);
  }

  void _formatExpiryDate(String value) {
    String cleaned = value.replaceAll('/', '');
    if (cleaned.length > 4) {
      cleaned = cleaned.substring(0, 4);
    }

    if (cleaned.length >= 2) {
      String month = cleaned.substring(0, 2);
      String year = cleaned.length > 2 ? cleaned.substring(2) : '';
      String formatted = year.isNotEmpty ? '$month/$year' : month;

      if (formatted != _expiryDateController.text) {
        _expiryDateController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    } else {
      if (cleaned != _expiryDateController.text) {
        _expiryDateController.value = TextEditingValue(
          text: cleaned,
          selection: TextSelection.collapsed(offset: cleaned.length),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPaymentInfoCard(theme, widget.package),
                AppSpace.heightSpace_24,
                _buildCardForm(theme),
                AppSpace.heightSpace_24,
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withAlpha(50),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );

  }

  Widget _buildPaymentInfoCard(ThemeData theme, InternetPackageModel package, ) {

    final packageTime = package.packageTime ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            getPackageColor(packageTime).withAlpha(30),
            getPackageColor(packageTime).withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: Theme.of(context).colorScheme.onPrimary, size: 28),
             AppSpace.widthSpace_8,
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (widget.description != null) ...[
            AppSpace.heightSpace_12,
            Text(
              widget.description!,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
          AppSpace.heightSpace_16,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مبلغ قابل پرداخت:',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      fontSize: 14),
                ),
                Text(
                  '${widget.amount.toString().seRagham().toPersianDigit()} تومان',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardForm(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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

          // شماره کارت
          TextFormField(
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText: 'شماره کارت',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              hintText: 'XXXX XXXX XXXX XXXX',
              prefixIcon: const Icon(Icons.credit_card),
                suffixIcon: _detectedBank != null
                    ? Tooltip(
                  message: _detectedBank!.name,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _detectedBank!.color.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _detectedBank!.imageAsset != null
                        ? Image.asset(
                      _detectedBank!.imageAsset!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    )
                        : Icon(
                      _detectedBank!.icon ?? Icons.credit_card,
                      color: _detectedBank!.color,
                      size: 24,
                    ),
                  ),
                )
                    : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              counterText: '',
            ),
            onChanged: (value) {
              _formatCardNumber(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'شماره کارت را وارد کنید';
              }
              String cleaned = value.replaceAll(' ', '');
              if (cleaned.length != 16) {
                return 'شماره کارت باید 16 رقم باشد';
              }
              if (!_isValidLuhn(cleaned)) {
                return 'شماره کارت معتبر نیست';
              }
              return null;
            },
          ),
          AppSpace.heightSpace_16,

          // تاریخ انقضا و CVV
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryDateController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.left,
                  maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'تاریخ انقضا',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: 'MM/YY',
                    prefixIcon: const Icon(Icons.date_range),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: '',
                  ),
                  onChanged: (value) {
                    _formatExpiryDate(value);
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
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
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
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return (sum % 10) == 0;
  }
}