import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.phoneNumberFormKey, required this.phoneNumberController});

  final GlobalKey<FormState> phoneNumberFormKey;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          AppColors.splashGradiantColor1,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromRGBO(
                255,
                255,
                255,
                0.12,
              ),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        onPressed: () {
          if (phoneNumberFormKey.currentState!.validate()) {
            context.push('/send_gift_states_page', extra: {
              'phoneNumber': phoneNumberController.text,
            });
          }
          },
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Text(
              'تایید و ادامه',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.appWhite,
              ),
            ),
            AppSpace.widthSpace_5,
            Icon(
              Icons.arrow_forward,
              color: Theme.of(context)
                  .elevatedButtonTheme
                  .style
                  ?.iconColor
                  ?.resolve({}),
            ),
          ],
        ),
      ),
    );
  }
}
