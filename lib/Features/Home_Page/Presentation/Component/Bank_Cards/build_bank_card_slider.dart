import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/add_card_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/bank_card.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/bank_card_shimmer.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/custom_Indicator.dart';

import '../../Bloc/Get_All_cards_Bloc/get_all_cards_bloc.dart';
import '../../Bloc/Get_All_cards_Bloc/get_all_cards_state.dart';

/// 🔹 اسلایدر کارت‌ها + بک‌گراند
Widget buildBankCardSlider(
  BuildContext context,
  CarouselSliderController controller,
  int current,
  ValueChanged<int> onPageChanged,
) {
  return BlocListener<GetAllCardsBloc, GetAllCardsState>(
    listener: (context, state) {
      if (state.status == GetAllCardsStatus.tokenExpired) {
        context.read<UserLoginAuthBloc>().add(LogoutEvent());
        Fluttertoast.showToast(
          msg: 'نشست شما منقضی شده، دوباره وارد شوید',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        context.go('/login_page');
      }

      if (state.status == GetAllCardsStatus.success &&
          state.cards != null &&
          state.cards!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.animateToPage(0);
        });
      }
    },
    child: BlocBuilder<GetAllCardsBloc, GetAllCardsState>(
      builder: (context, state) {
        if (state.status == GetAllCardsStatus.loading) {
          return BankCardShimmer();
        }

        final cards = state.cards ?? [];

        final cardItems = [
          ...cards.map((card) => buildBankCard(card)),
          buildAddCardButton(context),
        ];

        final initialPage = cards.isNotEmpty ? 0 : cardItems.length - 1;

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
                    color: AppColors.splashGradiantColor2.withValues(
                      alpha: 0.7,
                    ),
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
                    color: AppColors.splashGradiantColor2.withValues(
                      alpha: 0.7,
                    ),
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
                    color: AppColors.splashGradiantColor2.withValues(
                      alpha: 0.7,
                    ),
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
                      carouselController: controller,
                      options: CarouselOptions(
                        initialPage: initialPage,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          onPageChanged(index);
                        },
                      ),
                    ),
                  ),
                  buildIndicator(cardItems.length, current),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}
