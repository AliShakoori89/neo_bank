import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Widget/build_bank_card_slider.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/build_second_slider.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import '../../../Core/Const/app_colors.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import 'Component/Icon_Row_Widget/icon_row_widget.dart';
import 'Component/Transaction_List_Widget/transactions_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // @override
  // void initState() {
  //   BlocProvider.of<StatementBloc>(context).add(GetLastestStatmentEvent());
  //   super.initState();
  // }

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
              buildBankCardSlider(
                context,
                bankCardController,
                currentBankCard,
                (index, depositNumber) {
                  setState(() {
                    currentBankCard = index;
                    selectedCardDepositNumber = depositNumber;
                  });

                  context.read<StatementBloc>().add(
                    FetchStatementEvent(
                      depositNumber: depositNumber,
                      latestCount: 4,
                    ),
                  );
                },
              ),
              buildIconRow(),
              buildSecondSlider(
                context,
                facilitiesCardController,
                facilitiesCardCurrent,
                facilitiesCard,
                onPageChanged: (index) {
                  setState(() => facilitiesCardCurrent = index);
                },
              ),
              //لست تراکنش ها
              buildTransactionsListWidget(context, selectedCardDepositNumber),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
