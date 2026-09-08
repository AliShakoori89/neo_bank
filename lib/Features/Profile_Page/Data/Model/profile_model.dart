import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/profile_entity.dart';

class ProfileModel {
  final ProfileDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  ProfileModel({this.data, this.success, this.traceId, this.error});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      data: ProfileDataModel.fromJson(json['data']),

      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'],
    );
  }
}

class ProfileDataModel {
  final List<ProfileAddressModel>? addresses;
  final String? birthDate;
  final String? birthLocation;
  final String? birthLocationCode;
  final String? certificateSerial;
  final String? certificateSeries;
  final String? cif;
  final String? code;
  final String? fatherLatinName;
  final String? fatherName;
  final String? firstName;
  final int? gender;
  final String? group;
  final String? lastName;
  final String? latinFirstName;
  final String? latinLastName;
  final String? mobile;
  final String? name;
  final int? personalityType;
  final String? ssn;
  final String? title;

  ProfileDataModel({
    required this.addresses,
    required this.birthDate,
    required this.birthLocation,
    required this.birthLocationCode,
    required this.certificateSerial,
    required this.certificateSeries,
    required this.cif,
    required this.code,
    required this.fatherLatinName,
    required this.fatherName,
    required this.firstName,
    required this.gender,
    required this.group,
    required this.lastName,
    required this.latinFirstName,
    required this.latinLastName,
    required this.mobile,
    required this.name,
    required this.personalityType,
    required this.ssn,
    required this.title,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      addresses: json['addresses'] != null
          ? List<ProfileAddressModel>.from(
              json['addresses'].map((x) => ProfileAddressModel.fromJson(x)),
            )
          : null,
      birthDate: json['birthDate'] as String?,
      birthLocation: json['birthLocation'] as String?,
      birthLocationCode: json['birthLocationCode'] as String?,
      certificateSerial: json['certificateSerial'] as String?,
      certificateSeries: json['certificateSeries'] as String?,
      cif: json['cif'] as String?,
      code: json['code'] as String?,
      fatherLatinName: json['fatherLatinName'] as String?,
      fatherName: json['fatherName'] as String?,
      firstName: json['firstName'] as String?,
      gender: json['gender'] as int?,
      group: json['group'] as String?,
      lastName: json['lastName'] as String?,
      latinFirstName: json['latinFirstName'] as String?,
      latinLastName: json['latinLastName'] as String?,
      mobile: json['mobile'] as String?,
      name: json['name'] as String?,
      personalityType: json['personalityType'] as int?,
      ssn: json['ssn'] as String?,
      title: json['title'] as String?,
    );
  }

  ProfileEntity toEntity(){
    return ProfileEntity(
      title: title,
      ssn: ssn,
      personalityType: personalityType,
      name: name,
      mobile: mobile,
      latinLastName: latinLastName,
      latinFirstName: latinFirstName,
      lastName: lastName,
      group: group,
      gender: gender,
      firstName: firstName,
      fatherName: fatherName,
      fatherLatinName: fatherLatinName,
      code: code,
      cif: cif,
      certificateSeries: certificateSeries,
      certificateSerial: certificateSerial,
      birthLocationCode: birthLocationCode,
      birthLocation: birthLocation,
      birthDate: birthDate,
      addresses: addresses?.map((statement) => statement.toEntity())
          .toList(),
    );
  }
}

class ProfileAddressModel {
  final int? addressType;
  final String? phoneNumber;
  final String? postalAddress;
  final String? postalCode;

  ProfileAddressModel({
    this.addressType,
    this.phoneNumber,
    this.postalAddress,
    this.postalCode,
  });

  factory ProfileAddressModel.fromJson(Map<String, dynamic> json) {
    return ProfileAddressModel(
      addressType: json['addressType'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      postalAddress: json['postalAddress'] as String?,
      postalCode: json['postalCode'] as String?,
    );
  }

  ProfileAddressEntity toEntity(){
    return ProfileAddressEntity(
      postalCode: postalCode,
      postalAddress: postalAddress,
      phoneNumber: phoneNumber,
      addressType: addressType
    );
  }
}

