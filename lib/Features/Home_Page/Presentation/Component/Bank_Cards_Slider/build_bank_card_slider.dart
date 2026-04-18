import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/app_snackbar.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_state.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/Component/circle_1.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/Component/circle_2.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/Component/circle_3.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/add_card_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Bank_Cards/bank_card.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/card_box_background.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/bank_card_shimmer.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/custom_Indicator.dart';
import '../../../../../Core/Utils/App_Lock/Internet/button_internet_checker.dart';
import '../../../../../Core/Utils/App_Lock/Internet/internet_checker.dart';
import '../../../../Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import '../../../../Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import '../../../../Main_Page/main_page.dart';
import '../../Bloc/All_cards_Bloc/all_cards_state.dart';
import 'Bank_Cards/Bank_Card_details/bank_card_details.dart';

/// 🔹 اسلایدر کارت‌ها + بک‌گراند
Widget buildBankCardSlider(
  BuildContext context,
  CarouselSliderController controller,
  int current,
) {
  return BlocListener<RefreshCountBloc, RefreshCountState>(
    listener: (context, state) {
      if (state.status == RefreshCountStatus.refreshLimitExceeded) {
        AppSnackBar.errorTop(
          context,
          'تعداد دفعات بروزرسانی بیش از حد مجاز است',
        );
      }
    },
    child: BlocBuilder<RefreshCountBloc, RefreshCountState>(
      builder: (context, state) {
        int refreshCount = state.refreshCount;

        return BlocListener<AllCardsBloc, AllCardsState>(
          listener: (context, state) {
            if (state.status == GetAllCardsStatus.tokenExpired) {
              context.read<UserLoginAuthBloc>().add(LogoutEvent());
              AppSnackBar.errorTop(
                context,
                'نشست شما منقضی شده، دوباره وارد شوید',
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
          child: BlocBuilder<AllCardsBloc, AllCardsState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return BankCardShimmer();
              }
              if (state.cards != null && state.cards!.isNotEmpty) {
                final cards = state.cards ?? [];

                final cardItems = [
                  ...cards.map((card) => buildBankCard(card)),
                  buildAddCardButton(context),
                ];

                final initialPage = cards.isNotEmpty ? 0 : cardItems.length - 1;

                return Stack(
                  children: [
                    CardBoxBackground(),
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
                            child: InkWell(
                              onTap: (){
                                bankCardDetails(context, cards[current].pan!, cards[current].depositNumber!);
                              },
                              child: CarouselSlider(
                                items: cardItems,
                                carouselController: controller,
                                options: CarouselOptions(
                                  initialPage: initialPage,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.8,
                                ),
                              ),
                            ),
                          ),
                          buildIndicator(cardItems.length, current),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {

                        ButtonInternetChecker.checkInternet(
                          context: context,
                          onSuccess: () {
                            BlocProvider.of<RefreshCountBloc>(
                              context,
                            ).add(GetRefreshCountEvent());

                            if (refreshCount < 5) {
                              BlocProvider.of<AllCardsBloc>(
                                context,
                              ).add(GetUserAllCardsEvent());
                            } else {
                              AppSnackBar.errorTop(
                                context,
                                'تعداد دفعات بروزرسانی بیش از حد مجاز است',
                              );
                            }
                          },
                        );


                      },
                      icon: Icon(Icons.refresh,
                        color: AppColors.appWhite,
                      ),
                    ),
                  ],
                );
              }
              if (state.status.isError) {
                return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(child: Text('لطفا بعدا تلاش کنید.')));
              }

              return Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  CardBoxBackground(),
                  InkWell(
                      onTap: (){
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (_) => const MainPage(initialIndex: 0,)),
                        // );
                      },
                      child: FutureBuilder(
                        future: Future.delayed(Duration(seconds: 5)),
                        builder: (context, asyncSnapshot) {
                          return Icon(Icons.refresh, size: 50,);
                        }
                      ))
                ],
              );
            },
          ),
        );
      },
    ),
  );
}
