import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../Bloc/Create_Token_Bloc/create_token_bloc.dart';
import '../Bloc/Create_Token_Bloc/create_token_state.dart';
import '../Bloc/Validate_token_Bloc/validate_token_bloc.dart';
import '../Bloc/Validate_token_Bloc/validate_token_state.dart';

class CustomLoadingButton extends StatefulWidget {
  const CustomLoadingButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<CustomLoadingButton> createState() => _CustomLoadingButtonState();
}

class _CustomLoadingButtonState extends State<CustomLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTokenBloc, CreateTokenState>(
      builder: (context, createState) {

        return BlocBuilder<ValidateTokenBloc, ValidateTokenState>(
          builder: (context, validateState) {

            final isLoading =
                createState.status.isLoading ||
                    validateState.status.isLoading;

            return SizedBox(
              width: double.infinity,
              height: 48,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape:
                      WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            7.0,
                          ), // Adjust for desired corner radius
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        AppColors.splashGradiantColor1,
                      )),
                  onPressed: isLoading ? null : widget.onPressed,
                  child: isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text("تأیید و ادامه"),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
