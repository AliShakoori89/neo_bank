import '../../../../Core/Utils/api_error_model.dart';

class GetCitizenKycStatusModel {
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  GetCitizenKycStatusModel({this.success, this.traceId, this.error});
}