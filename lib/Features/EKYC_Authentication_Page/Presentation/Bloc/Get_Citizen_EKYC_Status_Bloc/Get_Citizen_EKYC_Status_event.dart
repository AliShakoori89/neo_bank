import 'package:equatable/equatable.dart';

abstract class GetCitizenEkycStatusEvent extends Equatable {
  const GetCitizenEkycStatusEvent();

  @override
  List<Object?> get props => [];
}

class EkycStateInquiryStatusEvent extends GetCitizenEkycStatusEvent {}