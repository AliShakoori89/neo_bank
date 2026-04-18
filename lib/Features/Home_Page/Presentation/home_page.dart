import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_state.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/build_bank_card_slider.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/build_second_slider.dart';
import '../../../Core/Const/app_colors.dart';
import '../../../Core/Utils/App_Lock/Internet/internet_checker.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import '../../Main_Page/main_page.dart';
import 'Component/Icon_Row_Widget/icon_row_widget.dart';
import 'Component/Transaction_List_Widget/transactions_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    _checkConnection();
    super.initState();
  }

  void _refreshPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainPage(initialIndex: 0,)),
    );
  }

  Future<void> _checkConnection() async {
    await InternetChecker.checkInternet(
      context: context,
      onSuccess: _refreshPage,
    );
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        body: SingleChildScrollView(
          child: Column(
            children: [
              customHeader(
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
              buildBankCardSlider(context, bankCardController, currentBankCard),
              buildIconRow(),
              buildSecondSlider(
                context,
                facilitiesCardController,
                facilitiesCardCurrent,
                facilitiesCard,
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
