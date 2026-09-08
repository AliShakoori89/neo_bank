import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Network/Internet/check_internet_when_press_button.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../../../../../Core/Widgets/app_snackbar.dart';
import '../../../../../Core/Widgets/error_refresh_widget.dart';
import '../../Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../Bloc/All_cards_Bloc/all_cards_event.dart';
import '../../Bloc/All_cards_Bloc/all_cards_state.dart';
import '../../Bloc/Card_Slider_Bloc/refresh_count_bloc.dart';
import '../../Bloc/Card_Slider_Bloc/refresh_count_event.dart';
import '../../Bloc/Card_Slider_Bloc/refresh_count_state.dart';
import 'Bank_Cards/Bank_Card_Component/add_card_button.dart';
import 'Bank_Cards/Bank_Card_Component/custom_Indicator.dart';
import 'Bank_Cards/Bank_Card_details/bank_card_details.dart';
import 'Bank_Cards/bank_card.dart';
import 'Card_Box_Background_UI/card_box_background.dart';
import 'bank_card_shimmer.dart';

/// 🔹 اسلایدر کارت‌ها + بک‌گراند
Widget buildBankCardSlider(
  BuildContext context,
  CarouselSliderController controller,
  int current,
  {required Function(int) onPageChanged}
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

            // if (state.status == GetAllCardsStatus.tokenExpired) {
            //   context.read<UserLoginAuthBloc>().add(LogoutEvent());
            //   AppSnackBar.errorTop(
            //     context,
            //     'نشست شما منقضی شده، دوباره وارد شوید',
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
                                  onPageChanged: (index, reason) {
                                    onPageChanged(index); // 👈 پدر را خبر کن
                                  },
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

                        CheckInternetWhenPressButton.checkInternet(
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
                return ErrorRefreshWidget(
                  refreshFunction: (){
                    BlocProvider.of<AllCardsBloc>(context).add(GetUserAllCardsEvent());
                  },
                );
              }

              return ErrorRefreshWidget(
                refreshFunction: (){
                  BlocProvider.of<AllCardsBloc>(context).add(GetUserAllCardsEvent());
                },
              );
            },
          ),
        );
      },
    ),
  );
}
