import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../../../../../Core/Widgets/custom_button.dart';
import '../../../../../Core/Widgets/custom_disable_button.dart';
import '../../../../Fund_Transfer_Page/Domain/Entities/ali_card_pan_entity.dart';
import '../../../../Fund_Transfer_Page/Domain/Entities/deposit_entity.dart';
import '../../../../Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import '../../../../Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_event.dart';
import '../../../../Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_state.dart';
import '../../../../Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import '../../../../Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import '../../../../Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_state.dart';
import '../../../../Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/Component/custom_vertical_divider.dart';

class CardIssuancePage extends StatefulWidget {
  const CardIssuancePage({super.key});

  @override
  State<CardIssuancePage> createState() => _CardIssuancePageState();
}

class _CardIssuancePageState extends State<CardIssuancePage> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    context.read<AllCardsDetailBloc>().add(GetAllCardsDetailEvent());
    context.read<UserAllAccountBloc>().add(GetUserAllAccountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpace.heightSpace_90,

              Text(
                'دریافت کارت بدون مراجعه به شعبه',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                ),
              ),

              AppSpace.heightSpace_48,

              _buildStep(
                context,
                number: '1',
                title: 'ثبت درخواست',
                description:
                'اگر کارت بانکی شما مفقود، خراب یا منقضی شده است یا دارای حسابی هستید که کارت ندارد، می توانید بدون مراجعه به شعبه، درخواست صدور کارت نمایید.',
              ),

              const CustomVerticalDivider(),

              _buildStep(
                context,
                number: '2',
                title: 'بررسی توسط بانک',
                description:
                'درخواست شما توسط بانک بررسی شده و کارت بانکی جدید برای شما صادر خواهد شد.',
              ),

              const CustomVerticalDivider(),

              _buildStep(
                context,
                number: '3',
                title: 'ارسال کارت',
                description:
                'در کمتر از 7 روز کاری، کارت جدید توسط پست تحویل شما داده خواهد شد. طی این مدت از مراجعه به شعبه و دریافت کارتی دیگر خودداری نمایید.',
              ),

              const Spacer(),

              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isSwitched,
                        activeColor:
                        Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value ?? false;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'شرایط و قوانین را خوانده و پذیرفته ام.',
                        ),
                      ),
                    ],
                  ),

                  Divider(
                    color: AppColors.loginPageHintFontColor,
                  ),

                  AppSpace.heightSpace_8,

                  _isSwitched
                      ? CustomButton(
                    buttonOnPressed: () {
                      _showAccountSelectionBottomSheet(
                        context,
                      );
                    },
                    buttonTitle: 'تایید و ادامه',
                  )
                      : CustomDisableButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(
      BuildContext context, {
        required String number,
        required String title,
        required String description,
      }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            Icons.check_circle,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        AppSpace.widthSpace_8,
        Expanded(
          flex: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${number.toPersianDigit()}.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpace.widthSpace_5,
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              AppSpace.heightSpace_4,
              Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showAccountSelectionBottomSheet(
      BuildContext context,
      ) async {
    final cardsState = context.read<AllCardsDetailBloc>().state;
    final accountsState = context.read<UserAllAccountBloc>().state;

    if (cardsState.status == AllCardsDetailStatus.loading ||
        accountsState.status == UserAllAccountStatus.loading) {
      _showLoadingBottomSheet(context);
      return;
    }

    if (cardsState.status != AllCardsDetailStatus.success ||
        accountsState.status != UserAllAccountStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اطلاعات حساب‌ها در دسترس نیست. لطفاً دوباره تلاش کنید.',
          ),
        ),
      );
      return;
    }

    final accounts = accountsState.allAccount ?? [];
    final cards = cardsState.cards ?? [];

    if (accounts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'حسابی برای انتخاب وجود ندارد.',
          ),
        ),
      );
      return;
    }

    final selection = await showModalBottomSheet<CardIssuanceSelection>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _AccountSelectionBottomSheet(
          accounts: accounts,
          cards: cards,
        );
      },
    );

    if (!context.mounted || selection == null) {
      return;
    }

    _onAccountSelected(
      context,
      selection,
    );
  }

  void _showLoadingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const SizedBox(
          height: 180,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _onAccountSelected(
      BuildContext context,
      CardIssuanceSelection selection,
      ) {
    /*
     * اینجا اطلاعات انتخاب‌شده را برای مرحله بعد استفاده کن.
     *
     * selection.accountNumber
     * selection.cardNumber
     *
     * اگر حساب کارت نداشته باشد:
     *
     * selection.cardNumber == null
     */

    debugPrint(
      'Selected account: ${selection.accountNumber}',
    );

    debugPrint(
      'Selected card: ${selection.cardNumber}',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          selection.cardNumber == null
              ? 'حساب ${selection.accountNumber} انتخاب شد.'
              : 'حساب ${selection.accountNumber} و کارت ${selection.cardNumber} انتخاب شد.',
        ),
      ),
    );

    // اینجا بعداً می‌توانی بروی صفحه بعد:
    //
    // context.push(
    //   '/select_design_page',
    //   extra: {
    //     'accountNumber': selection.accountNumber,
    //     'cardNumber': selection.cardNumber,
    //   },
    // );
  }
}

class CardIssuanceSelection {
  final String accountNumber;
  final String? cardNumber;

  const CardIssuanceSelection({
    required this.accountNumber,
    this.cardNumber,
  });
}

class _AccountSelectionBottomSheet extends StatefulWidget {
  final List<DepositEntity> accounts;
  final List<AliCardPanEntity> cards;

  const _AccountSelectionBottomSheet({
    required this.accounts,
    required this.cards,
  });

  @override
  State<_AccountSelectionBottomSheet> createState() =>
      _AccountSelectionBottomSheetState();
}

class _AccountSelectionBottomSheetState
    extends State<_AccountSelectionBottomSheet> {
  String? _selectedAccountNumber;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: bottomPadding + 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            AppSpace.heightSpace_16,

            Text(
              'انتخاب حساب',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            AppSpace.heightSpace_8,

            Text(
              'حساب موردنظر برای صدور کارت را انتخاب کنید.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),

            AppSpace.heightSpace_16,

            Flexible(
              child: RadioGroup<String>(
                groupValue: _selectedAccountNumber,
                onChanged: (value) {
                  setState(() {
                    _selectedAccountNumber = value;
                  });
                },
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.accounts.length,
                  separatorBuilder: (_, __) => AppSpace.heightSpace_8,
                  itemBuilder: (context, index) {
                    final account = widget.accounts[index];

                    final accountNumber = account.depositNumber;

                    if (accountNumber == null ||
                        accountNumber.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final card = _findCardForAccount(
                      accountNumber,
                    );

                    final isSelected =
                        _selectedAccountNumber == accountNumber;

                    return _AccountSelectionItem(
                      accountNumber: accountNumber,
                      cardNumber: card?.pan,
                      selected: isSelected,
                    );
                  },
                ),
              ),
            ),

            AppSpace.heightSpace_16,

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAccountNumber == null
                    ? null
                    : _confirmSelection,
                child: const Text(
                  'تایید و ادامه',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AliCardPanEntity? _findCardForAccount(
      String accountNumber,
      ) {
    for (final card in widget.cards) {
      if (card.depositNumber == accountNumber) {
        return card;
      }
    }

    return null;
  }

  void _confirmSelection() {
    final accountNumber = _selectedAccountNumber;

    if (accountNumber == null) {
      return;
    }

    final card = _findCardForAccount(accountNumber);

    Navigator.of(context).pop(
      CardIssuanceSelection(
        accountNumber: accountNumber,
        cardNumber: card?.pan,
      ),
    );
  }
}

class _AccountSelectionItem extends StatelessWidget {
  final String accountNumber;
  final String? cardNumber;
  final bool selected;

  const _AccountSelectionItem({
    required this.accountNumber,
    required this.cardNumber,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RadioGroup.maybeOf<String>(context)?.onChanged.call(
          accountNumber,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: accountNumber,
            ),

            AppSpace.widthSpace_8,

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'شماره حساب',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),

                  AppSpace.heightSpace_4,

                  Text(
                    accountNumber,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),

                  if (cardNumber != null) ...[
                    AppSpace.heightSpace_8,

                    Text(
                      'شماره کارت',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall,
                    ),

                    AppSpace.heightSpace_4,

                    Text(
                      cardNumber!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}