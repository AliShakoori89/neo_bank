class ProfileEntity {
  final List<ProfileAddressEntity>? addresses;
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

  ProfileEntity({this.addresses, this.birthDate, this.birthLocation, this.birthLocationCode, this.certificateSerial, this.certificateSeries, this.cif, this.code, this.fatherLatinName, this.fatherName, this.firstName, this.gender, this.group, this.lastName, this.latinFirstName, this.latinLastName, this.mobile, this.name, this.personalityType, this.ssn, this.title});
}

class ProfileAddressEntity{
  final int? addressType;
  final String? phoneNumber;
  final String? postalAddress;
  final String? postalCode;

  ProfileAddressEntity({this.addressType, this.phoneNumber, this.postalAddress, this.postalCode});
}