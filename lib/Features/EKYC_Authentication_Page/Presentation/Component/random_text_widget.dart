import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Theme/app_colors.dart';
import '../Bloc/Random_Text_Bloc/random_text_bloc.dart';
import '../Bloc/Random_Text_Bloc/random_text_state.dart';

Widget randomTextWidget(theme, randomText){
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: theme.appBarTheme.titleTextStyle!.color!,
      ),
    ),
    child: BlocBuilder<RandomTextBloc, RandomTextState>(
        builder: (context, state) {
          if(state.status.isLoading){
            return const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(state.status.isSuccess){

            randomText = state.randomText.data!.result!.first;

            return Text(
              state.randomText.data!.result!.first,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.8,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          return Center(
            child: Text(state.errorMessage, style: const TextStyle(
                color: AppColors.redColor
            ),),
          );
        }
    ),
  );
}