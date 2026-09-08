import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Services/check_connection_service.dart';
import '../../../Core/Widgets/custom_header.dart';
import '../../../Core/Widgets/neo_bank_logo.dart';
import 'Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'Bloc/All_cards_Bloc/all_cards_state.dart';
import 'Component/Bank_Cards_Slider/build_bank_card_slider.dart';
import 'Component/Icon_Row_Widget/icon_row_widget.dart';
import 'Component/Transaction_List_Widget/transactions_list_widget.dart';
import 'Component/build_second_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    checkConnection(context);
    super.initState();
  }

  final CarouselSliderController bankCardController =
      CarouselSliderController();
  final CarouselSliderController facilitiesCardController =
      CarouselSliderController();
  int currentBankCard = 0;
  int facilitiesCardCurrent = 0;

  String? selectedCardDepositNumber;

  final List<Map<String, String>> facilitiesCard = [
    {
      'card_title': 'تسهیلات فوری تا سقف',
      'card_value': '100000000',
      'card_image': 'assets/image/banking-finance-bank-money.png',
    },
    {
      'card_title': 'تسهیلات فوری تا سقف',
      'card_value': '200000000',
      'card_image': 'assets/image/banking-finance-bank-money.png',
    },
    {
      'card_title': 'تسهیلات فوری تا سقف',
      'card_value': '300000000',
      'card_image': 'assets/image/banking-finance-bank-money.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              navHeader(
                context,
                NeoBankLogo(
                  logoColor: AppColors.splashGradiantColor1,
                  width: 88,
                  height: 24,
                  logoHeight: 20,
                  logoWidth: 62,
                  space: 4,
                ),
              ),
              buildBankCardSlider(
                  context,
                  bankCardController,
                  currentBankCard,
                  onPageChanged: (index) => setState(() => currentBankCard = index)),
              allServicesList(),
              buildSecondSlider(
                  context,
                  facilitiesCardController,
                  facilitiesCardCurrent,
                  facilitiesCard,
                  onPageChanged: (index) => setState(() => facilitiesCardCurrent = index)
              ),
              //لست تراکنش ها
              BlocBuilder<AllCardsBloc, AllCardsState>(
                builder: (context, state) {
                  return TransactionsListWidget(
                    depositNumber: state.cards!.isNotEmpty
                        ? state.cards!.first.depositNumber
                        : null,
                  );
                },
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
