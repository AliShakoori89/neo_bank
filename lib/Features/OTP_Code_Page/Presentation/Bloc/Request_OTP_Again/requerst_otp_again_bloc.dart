// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/request_otp_code_again_repository.dart';
// import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/requerst_otp_again_event.dart';
// import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/requerst_otp_again_state.dart';

// class RequerstOtpAgainBloc
//     extends Bloc<RequerstOtpAgainEvent, RequerstOtpAgainState> {
//   RequestOtpCodeAgainRepository requestOtpCodeAgainRepository;

//   RequerstOtpAgainBloc(this.requestOtpCodeAgainRepository)
//     : super(RequerstOtpAgainState.initial()) {
//     on<RequestOTPCodeAgainEvent>(_mapRequestOTPCodeAgainEventToState);
//   }

//   void _mapRequestOTPCodeAgainEventToState(
//     RequestOTPCodeAgainEvent event,
//     Emitter<RequerstOtpAgainState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: RequerstOtpAgainStatus.loading));

//       final logedin = await requestOtpCodeAgainRepository.requestOTPAgain(
//         event.nationalCode,
//         event.phoneNumber,
//       );

//       emit(
//         state.copyWith(
//           status: RequerstOtpAgainStatus.success,
//           loginStatus: logedin![0],
//           loginMessage: logedin[1],
//           deviceId: logedin[2],
//           secretKey: logedin[3],
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: RequerstOtpAgainStatus.error));
//     }
//   }
// }
