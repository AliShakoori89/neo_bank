import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/Card_Box_Background_UI/circle_1.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/Card_Box_Background_UI/circle_2.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/Card_Box_Background_UI/circle_3.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/add_card_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/bank_card.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/bank_card_shimmer.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/custom_Indicator.dart';
import '../../Bloc/All_cards_Bloc/all_cards_state.dart';

/// 🔹 اسلایدر کارت‌ها + بک‌گراند
Widget buildBankCardSlider(
  BuildContext context,
  CarouselSliderController controller,
  int current,
  ValueChanged<int> onPageChanged,
) {
  return BlocListener<AllCardsBloc, AllCardsState>(
    listener: (context, state) {
      // if (state.status == GetAllCardsStatus.tokenExpired) {
      //   context.read<UserLoginAuthBloc>().add(LogoutEvent());
      //   Fluttertoast.showToast(
      //     msg: 'نشست شما منقضی شده، دوباره وارد شوید',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //   );
      //   context.go('/login_page');
      // }

      if (state.status == GetAllCardsStatus.success &&
          state.cards != null &&
          state.cards!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.animateToPage(0);
        });
      }
    },
    child: BlocBuilder<AllCardsBloc, AllCardsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return BankCardShimmer();
        }
        if (state.status.isSuccess) {
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
              Circle1(),

              /// Circle 2
              Circle2(),

              /// Circle 3
              Circle3(),

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
        }
        if (state.status.isError) {
          return Center(child: Text('لطفا بعدا تلاش کنید.'));
        }

        return Center(child: Text('لطفا بعدا تلاش کنید.'));
      },
    ),
  );
}
