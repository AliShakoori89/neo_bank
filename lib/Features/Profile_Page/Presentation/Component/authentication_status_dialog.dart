import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart';
import '../Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_event.dart';
import '../Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_state.dart';

Future<void> authenticationStatusDialog(BuildContext context, ThemeData theme) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return BlocBuilder<CitizenEkycStatusBloc, CitizenEkycStatusState>(
        builder: (context, state) {

          // Loading
          if (state.status.isLoading) {
            return AlertDialog(
              backgroundColor: theme.colorScheme.onPrimaryFixed,
              content: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('در حال دریافت اطلاعات...')
                  ],
                ),
              ),
            );
          }

          // Success
          if (state.status.isSuccess) {
            final ekycAuth = state.citizenEkycStatus;

            return AlertDialog(
              backgroundColor: theme.colorScheme.onPrimaryFixed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Icon(
                    ekycAuth
                        ? Icons.verified_user
                        : Icons.warning_amber_rounded,
                    color: ekycAuth
                        ? Colors.green
                        : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  const Text('وضعیت احراز هویت'),
                ],
              ),
              content: Text(
                ekycAuth
                    ? 'احراز هویت شما با موفقیت انجام شده است.'
                    : 'احراز هویت شما هنوز تکمیل نشده است.',
                style: const TextStyle(fontSize: 15),
              ),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('بستن'),
                ),

                if (!ekycAuth)
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                      context.push('/ekyc_gate_page');
                    },
                    child: const Text('شروع احراز هویت'),
                  ),
              ],
            );
          }

          // Error
          if (state.status.isError) {
            return AlertDialog(
              backgroundColor: theme.colorScheme.onPrimaryFixed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text('خطا'),
                ],
              ),
              content: Text(
                state.errorMessage.isNotEmpty
                    ? state.errorMessage
                    : 'ارتباط با سرور برقرار نشد. لطفاً چند دقیقه دیگر دوباره تلاش کنید.',
              ),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('بستن'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CitizenEkycStatusBloc>()
                        .add(FetchCitizenEkycStatusEvent());
                  },
                  child: const Text('تلاش مجدد'),
                ),
              ],
            );
          }

          // Initial
          return const SizedBox.shrink();
        },
      );
    },
  );
}
