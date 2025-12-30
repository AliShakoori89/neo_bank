import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_All_cards_Bloc/get_all_cards_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_All_cards_Bloc/get_all_cards_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_All_cards_Bloc/get_all_cards_state.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/card_number_and_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../Core/Const/app_colors.dart';
import '../../../Core/Const/app_space.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'Component/add_card_button.dart';
import 'Component/card_balance.dart';
import 'Component/card_header.dart';
import 'Component/custom_Indicator.dart';
import 'Component/icon_row_widget.dart';
import 'Component/transactions_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _controller = CarouselSliderController();
  final CarouselSliderController _controller1 = CarouselSliderController();
  int _current = 0;
  int _current1 = 0;

  // final List<Map<String, String>> sampleCard = [];

  final List<Map<String, String>> sampleCard = [
    {'card_number': '6063732514168589', 'card_expire_date': '08/06'},
    {'card_number': '5022291075418596', 'card_expire_date': '11/27'},
  ];

  final List<Map<String, String>> sampleCard2 = [
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
  void initState() {
    super.initState();
    BlocProvider.of<GetAllCardsBloc>(context).add(GetUserAllCardsEvent());
  }

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
              BlocListener<GetAllCardsBloc, GetAllCardsState>(
                listener: (context, state) {
                  if (state.status == GetAllCardsStatus.tokenExpired) {
                    context.read<UserLoginAuthBloc>().add(LogoutEvent());
                    context.go('/login_page');
                  }
                  if (state.status == GetAllCardsStatus.tokenExpired) {
                    Fluttertoast.showToast(
                      msg: 'نشست شما منقضی شده، دوباره وارد شوید',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
                child: BlocBuilder<GetAllCardsBloc, GetAllCardsState>(
                  builder: (context, state) {
                    if (state.status == GetAllCardsStatus.loading) {
                      return const SizedBox(
                        height: 192,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return _buildBankCardSlider(context, state.cards ?? []);
                  },
                ),
              ),
              buildIconRow(),
              _buildSecondSlider(),
              //لست تراکنش ها
              buildTransactionsList(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 اسلایدر کارت‌ها + بک‌گراند
  Widget _buildBankCardSlider(
    BuildContext context,
    List<CardDataModel>? cards,
  ) {
    final List<Widget> cardItems = [
      ...cards!.map((card) => _buildBankCard(card)),
      buildAddCardButton(context),
    ];

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 268,
          color: AppColors.splashGradiantColor1,
        ),

        /// Circle 1
        Positioned(
          right: -220,
          top: 50,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 16.1, sigmaY: 16.1),
            child: Container(
              width: 383,
              height: 383,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashGradiantColor2.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),

        /// Circle 2
        Positioned(
          right: 100,
          top: -250,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 16.1, sigmaY: 16.1),
            child: Container(
              width: 383,
              height: 383,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashGradiantColor2.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),

        /// Circle 3
        Positioned(
          right: 250,
          top: 150,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 16.1, sigmaY: 16.1),
            child: Container(
              width: 195,
              height: 195,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashGradiantColor2.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 192,
                constraints: const BoxConstraints(
                  minWidth: 320,
                  minHeight: 192,
                ),
                child: CarouselSlider(
                  items: cardItems,
                  carouselController: _controller,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() => _current = index);
                    },
                  ),
                ),
              ),
              buildIndicator(cardItems.length, _current),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 کارت بانکی
  Widget _buildBankCard(CardDataModel card) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE0E0E0), // رنگ دلخواه border
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.splashGradiantColor2.withValues(alpha: 0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
            child: Column(
              children: [
                buildCardHeader(),
                const Spacer(),
                buildCardNumberAndDate(card),
                AppSpace.heightSpace_12,
                buildCardBalance(),
              ],
            ),
          ),
        ),
        // 🔹 لایه اول (gradient سیاه)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(
                109.8 * (3.1415926 / 180),
              ), // تبدیل درجه به رادیان
              colors: [
                Color.fromRGBO(0, 0, 0, 0.016),
                Color.fromRGBO(0, 0, 0, 0.08),
              ],
              stops: [0.0011, 1.0011], // معادل درصدها در CSS
            ),
          ),
        ),

        // 🔹 لایه دوم (gradient سفید)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(111.42 * (3.1415926 / 180)),
              colors: [
                Color.fromRGBO(255, 255, 255, 0.06),
                Color.fromRGBO(255, 255, 255, 0.0),
              ],
              stops: [0.0, 0.9998],
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 اسلایدر دوم
  Widget _buildSecondSlider() {
    final cardItems2 = sampleCard2
        .map(
          (card) => BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, theme) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: theme == AppTheme.lightTheme ? 2 : 0,
                    color: AppColors.appWhite,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(
                      45 * (3.1415926 / 180),
                    ), // تبدیل درجه به رادیان
                    colors: [
                      AppColors.homePageTitleColor,
                      AppColors.splashGradiantColor1,
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          card['card_title'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.appWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${card['card_value']}'.seRagham().toPersianDigit(),
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.appWhite,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      card['card_image'] ?? '',
                      width: 78,
                      height: 54,
                    ),
                  ],
                ),
              );
            },
          ),
        )
        .toList();

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      height: 140,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            CarouselSlider(
              items: cardItems2,
              carouselController: _controller1,
              options: CarouselOptions(
                height: 120,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() => _current1 = index);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cardItems2.length,
                    (index) => Container(
                      width: 24,
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: _current1 == index
                            ? AppColors.appWhite
                            : AppColors.splashGradiantColor2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
