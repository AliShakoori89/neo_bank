import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Widgets/app_snackbar.dart';
import '../Bloc/Get_EKYC_State_Inquiry_Bloc/get_ekyc_state_inquiry_bloc.dart';
import '../Bloc/Get_EKYC_State_Inquiry_Bloc/get_ekyc_state_inquiry_event.dart';
import '../Bloc/Get_EKYC_State_Inquiry_Bloc/get_ekyc_state_inquiry_state.dart';

class EkycGatePage extends StatefulWidget {
  const EkycGatePage({super.key});

  @override
  State<EkycGatePage> createState() => _EkycGatePageState();
}

class _EkycGatePageState extends State<EkycGatePage> {
  @override
  void initState() {
    super.initState();

    context.read<GetEkycStateInquiryBloc>().add(
      GetEkycStateInquiryStatusEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
        GetEkycStateInquiryBloc,
        GetEkycStateInquiryState>(
      listener: (context, state) {

        if (state.status.isSuccess) {

          if (state.state == 2) {
            context.go('/send_video_page');
          } else {
            context.go('/ekyc_first_step_auth_page');
          }
        }else if(state.status.isError){

          Future.delayed(Duration(seconds: 3), () {
            AppSnackBar.errorTop(context, state.errorMessage);
            context.go('/main_page');
          },);

        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

  }
}