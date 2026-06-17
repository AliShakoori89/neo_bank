class ApiErrorModel {
  final int? errorCode;
  final String? errorMessage;
  final String? owner;

  ApiErrorModel({
    this.errorCode,
    this.errorMessage,
    this.owner,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
      owner: json['owner'],
    );
  }
}