import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/Loan_Page_Bloc/loan_page_bloc.dart';
import '../../Bloc/Loan_Page_Bloc/loan_page_event.dart';
import '../../Bloc/Loan_Page_Bloc/loan_page_state.dart';
import '../Charge_Internet_Page/Component/custom_header.dart';
import 'Component/loan_card.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  void initState() {
    super.initState();

    context.read<LoanPageBloc>().add(
      AllLoanPageListEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'لیست تسهیلات',
              hasBackArrow: false,
            ),

            Expanded(
              child: BlocBuilder<LoanPageBloc, LoanPageState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.status.isError) {
                    return const Center(
                      child: Text(
                        'خطا در دریافت لیست تسهیلات',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  }

                  if (state.status.isSuccess) {
                    final loans = state.loan;

                    if (loans.isEmpty) {
                      return const Center(
                        child: Text(
                          'تسهیلاتی برای نمایش وجود ندارد',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: loans.length,
                      itemBuilder: (context, index) {
                        final loan = loans[index];

                        return LoanCard(
                          loan: loan,
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

