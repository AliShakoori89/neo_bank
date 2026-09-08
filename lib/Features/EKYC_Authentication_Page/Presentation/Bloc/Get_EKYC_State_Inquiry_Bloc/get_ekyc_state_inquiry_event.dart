import 'package:equatable/equatable.dart';

abstract class GetEkycStateInquiryEvent extends Equatable {
  const GetEkycStateInquiryEvent();

  @override
  List<Object?> get props => [];
}

class GetEkycStateInquiryStatusEvent extends GetEkycStateInquiryEvent {}